class Query < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :participation

  validates_presence_of :participation_id#, :status, :respond_by, :responded_at
  # validates_inclusion_of :status, :in => %w(yes no)
  after_save :auto_approve_check

  scope :accepted, -> { where(status: :yes) }
  scope :rejected, -> { where(status: :no)  }
  scope :open,     -> { where(status: :waiting)  }


  def user
    self.participation.user
  end

  def mark_as_no_waiting! #we got rid of the option of "no_waiting" but are afraid to change too much shit
    self.update_attributes(status: :waiting)
  end

  def decision
    self.proposal.decision
  end

  def auto_approve_check
    QueryCleanupWorker.perform_at(15.minutes.from_now, self.id)
  end

  def open?
    self.status == "waiting"
  end

end


# scope :active, -> {
#   where(created_at: (Time.now - 1.day)..Time.now, gold_member: true, registered: true)
# }



# where status is in ["no_waiting "] AND is NULL
