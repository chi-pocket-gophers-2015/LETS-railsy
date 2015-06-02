module DecisionsHelper

  def participants_list(decision)
    participants = decision.participants
    particiapnts.map { |participant| participant.name }.join(", ")
  end

end
