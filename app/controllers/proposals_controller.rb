class ProposalsController < ApplicationController
  before_action :set_decision
  before_action :set_current_participation

  def new
  end

  def create
    if params[:proposal][:proposed_idea] != ""
      QueryService.create_proposal(@decision, @current_participation, params[:proposal][:proposed_idea])
      redirect_to decision_path(@decision)
    else
      flash.now[:error] = "Your proposal could not be created; please try again."
      render(:new)
    end
  end


  protected

  def set_decision
    @decision ||= Decision.find_by(id: params[:decision_id])
  end

  def set_current_participation
    @current_participation ||= Participation.find_by(user: current_user, decision: @decision)
  end



end
