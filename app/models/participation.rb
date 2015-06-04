class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :decision
  has_many   :proposals
  has_many   :queries

  validates_presence_of :user, :decision

  validates_uniqueness_of :user, scope: :decision, message: "You already added that friend!"

end
