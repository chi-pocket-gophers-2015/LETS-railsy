class Proposal < ActiveRecord::Base
  belongs_to :participation
  has_many   :queries

  def proposer
    @_proposer ||= self.participation.user
  end

  def decision
    @_decision ||= self.participation.decision
  end

  def participations
    @_participations ||= self.decision.participations
  end

  def already_voted
    @_already_voted ||= self.queries.pluck(:participation_id).sort.map {|id| Participation.find(id)}
  end

  def not_yet_voted
    @_not_yet_voted ||= (participations - already_voted).sort
  end

  def ordered_participations
    @_ordered_participations ||= not_yet_voted + already_voted
  end

  def next_voter
    ordered_participations[0] #this won't persist correct order
  end

  validates_presence_of :status, :proposed_idea, :participation_id
  # validates_inclusion_of :status, :in => %w(accepted refused open)
end
