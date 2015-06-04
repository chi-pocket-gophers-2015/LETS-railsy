class QueryCleanupWorker
  include Sidekiq::Worker

  # def perform(decision_id)
  #   while Decision.find_by(id:decision_id).is_active
  #     approve_expired_queries(decision_id)
  #     sleep(15)
  #   end
  # end

  # def approve_expired_queries(decision_id)
  #   query = Decision.find_by(id: decision_id).proposals.open.first.current_open_query

  #   if query.respond_by < Time.now
  #     QueryService.approve(query)
  #   end
  # end


  def perform(query_id)
    approve_expired_query(query_id)
  end

  def approve_expired_query(query_id)
    query = Query.find_by(id: query_id)

    if query.open? && query.respond_by < Time.now
      QueryService.approve(query)
    end
  end



end

