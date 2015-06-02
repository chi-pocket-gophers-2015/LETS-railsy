module DecisionsHelper

  def participants_list(decision)
    participants = decision.participants
    particiapnts.map { |participant| participant.name }.join(", ")
  end

  def response_path(payload={})
    decision_proposal_query_path(@decision.id, @current_proposal.id, @current_query.id, payload)
  end
end
