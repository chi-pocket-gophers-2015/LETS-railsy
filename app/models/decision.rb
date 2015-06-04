class Decision < ActiveRecord::Base
  has_many :participations
  has_many :participants, through: :participations, source: :user
  has_many :proposals, through: :participations
  # has_one  :winning_proposal, through: :participations, source: :proposal

  validates_presence_of :context
  # before_update :more_than_one_participant

  def more_than_one_participant
    self.participants.count > 1
  end


  def approve!
    self.update_attributes(is_active: false)
  end
end
