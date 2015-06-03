class QueryCleanupWorker
  include Sidekiq::Worker

  def perform(decision_id)
    while Decision.find_by(id:decision_id).is_active
      approve_expired_queries(decision_id)
      sleep(15)
    end
  end

  def approve_expired_queries(decision_id)
    # decision = Decision.find_by(id: decision_id)
    # open_proposal = decision.proposals.open.first
    # expired_queries = open_proposal.queries

    # expired_queries = Decision.find_by(id: decision_id).proposals.open.first.queries.where("status IS NULL OR status IN (?)",["no_waiting"]).where("respond_by < (?)", Time.now)
    # expired_queries.each do |query|
    #   QueryService.approve(query)
    #   #send email to the user saying they've auto approved
    # end

    query = Decision.find_by(id: decision_id).proposals.open.first.current_open_query

    if (query.status == nil || query.status == "no_waiting") && query.respond_by < Time.now
      QueryService.approve(query)
    end
  end


end

# queries_of_active_proposal

# if query.status is empty or no_waiting AND respond_by < Time.now
#   QueryService.approve(query)
