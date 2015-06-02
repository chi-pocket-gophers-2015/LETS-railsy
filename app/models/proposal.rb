class Proposal < ActiveRecord::Base
  belongs_to :participation
  has_many   :queries
  has_many   :query_participations, through: :queries, source: :participation

  validates_presence_of :status, :proposed_idea, :participation_id
  # validates_inclusion_of :status, :in => %w(accepted refused open)

  scope :open, -> { where(status: :open) }
  scope :approved, -> { where(status: :approved) }

  def decision
    self.participation.decision
  end

  def participations
    self.decision.participations
  end

  def next_participation
    not_yet_voted.shuffle.first
  end

  def not_yet_voted
    self.participations.where('id NOT IN (?)', self.queries.includes(:participation).accepted.map {|x| x.participation_id })
  end

  def already_voted
    self.query_participations.where('queries.status IS NOT NULL')
  end

  def current_open_query
    self.queries.open.first
  end

  def approve!
    self.update_attributes(status: :approved)
  end

  def reject!
    self.update_attributes(status: :rejected)
  end
end
