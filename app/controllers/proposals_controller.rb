class ProposalsController < ApplicationController
  before_action :set_decision
  before_action :set_current_participation

  def new
  end

  def create
    if QueryService.create_proposal(@decision, @current_participation, params[:proposal][:proposed_idea])
      redirect_to decision_path(@decision)
    else
      # create an error to be displayed on the weird side of the left
      redirect_to new_decision_proposal_path(@decision)
    end
  end

  protected

  def set_decision
    @decision ||= Decision.find_by(id: params[:decision_id])
  end

  def set_current_participation
    @current_participation ||= Participation.find_by(user: current_user, decision: @decision)
  end

  # def email_current_voter
  #   UserMailer.notify_of_turn_to_vote(next_participation).deliver
  # end

end
