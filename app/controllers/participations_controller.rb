class ParticipationsController < ApplicationController
  def new
    @decision = Decision.find(params[:decision_id])
    @participation = Participation.new
    @participations = @decision.participations
  end

  def create
    user = User.find_by_email(params[:participation][:user])
    @decision = Decision.find(params[:decision_id])

    if user
      QueryService.add_user(@decision, user)
      redirect_to new_decision_participation_path(@decision)
    else
      flash[:error] = "User not found! Please try again."
      redirect_to new_decision_participation_path(@decision)
    end
  end
end
