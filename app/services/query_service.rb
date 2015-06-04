class QueryService
  WAIT_TIME = 15 * 60 #for converting time from seconds to minutes

  def self.create_decision(context)
    Decision.create(context)
  end

  def self.add_user(decision, user)
    user.decisions << decision
    ProposalMailer.notify_of_invitation(user).deliver_now
  end

  # Start a new proposal
  def self.create_proposal(decision, current_participation, idea)
    if decision.proposals.length > 0
      decision.proposals.open.first.update_prior_query
    end
    decision.proposals.open.each {|p| p.reject!}
    proposal = propose(current_participation, idea)
    create_query(proposal)
    set_changed_on(decision)
  end

  # Update a query with a yes
  def self.approve(query)#, current_participation)
    query.update_attributes(status: :yes, responded_at: Time.now)
    if next_participation = query.proposal.next_participation
      create_query(query.proposal, next_participation)
    else
      close(query)
    end
    query
    set_changed_on(query.proposal.decision)
  end

  # Update a query with a no
  def self.reject(query)
    query.mark_as_no_waiting!
  end

  # Close a decision
  def self.close(query)
    decision = query.decision
    users = query.decision.participants
    query.proposal.approve!
    query.decision.approve!
    users.each do |user|
      ProposalMailer.notify_of_final_decision(user, decision).deliver_now
    end
    set_changed_on(decision)
  end

  protected

  def self.set_changed_on(decision, user=nil)
    decision.participations.each do |participation|
      CacheChanged.write(decision.id, participation.user_id, true)
    end
  end

  def self.propose(current_participation, idea)
    proposal = current_participation.proposals.create(proposed_idea: idea)
    proposal.queries.create(status: :yes, participation: current_participation) # seed the queries with your own 'yes'
    proposal
  end

  def self.create_query(proposal, next_participation=nil)
    unless proposal.next_participation.nil?
      user = proposal.next_participation.user
      ProposalMailer.notify_of_turn_to_vote(user).deliver_now
      proposal.queries.create(participation: next_participation || proposal.next_participation, respond_by: Time.now + WAIT_TIME)
    end
  end
end
