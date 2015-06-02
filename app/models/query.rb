class Query < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :participation

  def user
    @_user ||= self.participation.user
  end

  # has_one    :user, through: :participation # replaced by Query#user

  validates_presence_of :participation_id, :status#, :respond_by, :responded_at
  # validates_inclusion_of :status, :in => %w(yes no)

end
