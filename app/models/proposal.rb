class Proposal < ActiveRecord::Base
  belongs_to :participation
  has_many   :queries

  validates_presence_of :status, :proposed_idea, :participation_id
# validates_inclusion_of :status, :in => %w(accepted refused open)



  def sorted_participations
    @_participations ||= self.decision.participations.sort
  end

  def already_voted_participations
    @_already_voted ||= self.queries.pluck(:participation_id).sort.map {|id| Participation.find(id)}
  end

  def not_yet_voted
    @_not_yet_voted ||= (sorted_participations - already_voted_participations)
  end

  def current_voter_at_top
    @_ordered_participations ||= not_yet_voted + already_voted_participations
  end

  def current_voter
    @_current_voter ||= not_yet_voted.shift
  end

  def not_yet_voted_minus_current_voter
    @_not_yet_voted_minus_current_voter ||= not_yet_voted.delete(current_voter)
    not_yet_voted
  end

# helper methods
  def decision
    @_decision ||= self.participation.decision
  end

  # def self.proposer
  #   @_proposer ||= self.participation.user
  # end



end
