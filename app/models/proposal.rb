class Proposal < ActiveRecord::Base
  belongs_to :participation
  has_many   :queries

  def proposer
    @_proposer ||= self.participation.user
  end

  def decision
    @_decision ||= self.participation.decision
  end

  validates_presence_of :status, :proposed_idea, :participation_id
  # validates_inclusion_of :status, :in => %w(accepted refused open)
end
