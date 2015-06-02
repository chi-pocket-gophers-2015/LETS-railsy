class Query < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :participation

  validates_presence_of :participation_id#, :status, :respond_by, :responded_at
  # validates_inclusion_of :status, :in => %w(yes no)

  scope :accepted, -> { where(status: :yes) }
  scope :rejected, -> { where(status: :no)  }
  scope :open,     -> { where(status: nil)  }

  def user
    self.participation.user
  end

  def mark_as_no_waiting!
    self.update_attributes(status: :no_waiting)
  end

  def decision
    self.proposal.decision
  end
end
