class Decision < ActiveRecord::Base
  has_many :participations
  has_many :participants, through: :participations, source: :user
  has_many :proposals, through: :participations
  # has_one  :winning_proposal, through: :participations, source: :proposal

  validates_presence_of :context
end
