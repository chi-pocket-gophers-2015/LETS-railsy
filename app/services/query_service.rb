class QueryService
  WAIT_TIME = 15 * 60 #for converting time from seconds to minutes

  def self.create_decision(context)
  end

  def self.add_user(decision, user)
  end

  # Start a new decision
  def self.create_proposal(decision, current_participation, idea)
  end

  # Update a query with a yes
  def self.approve(query, current_participation)
  end

  # Update a query with a no
  def self.reject(query)
  end

  # Close a decision
  def self.close(query)
  end
end
