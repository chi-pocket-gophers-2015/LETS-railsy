class QueryService
  WAIT_TIME = 15 * 60 #for converting time from seconds to minutes

  def self.create_decision(context)
    Decision.create(context)
  end

  def self.add_user(decision, user)
    user.decisions << decision
  end

  # Start a new decision
  def self.create_proposal(decision, current_participation, idea)
    decision.proposals.open.each {|p| p.reject! }
    proposal = propose(current_participation, idea)
    create_query(proposal)
  end

  # Update a query with a yes
  def self.approve(query, current_participation)
    query.update_attributes(status: :yes)
    if next_participation = query.proposal.next_participation
      create_query(query.proposal, next_participation)
    else
      close(query)
    end
    query
  end

  # Update a query with a no
  def self.reject(query)
    query.mark_as_no_waiting!
  end

  # Close a decision
  def self.close(query)
    query.proposal.approve!
    query.decision.approve!
  end

  protected

  def self.propose(current_participation, idea)
    proposal = current_participation.proposals.create(proposed_idea: idea)
    proposal.queries.create(status: :yes, participation: current_participation) # seed the queries with your own 'yes'
    proposal
  end

  def self.create_query(proposal, next_participation=nil)
    proposal.queries.create(participation: next_participation || proposal.next_participation, respond_by: Time.now + WAIT_TIME)
  end
end
