class ProcessExpiredQueries
include Sidekiq::Worker

  def perform(decision)

    until !decision.is_active
      Decision.create(context: "MEOW")
      sleep(5)
    end

  end

end
