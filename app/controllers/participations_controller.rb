class ParticipationsController < ApplicationController
  def new
    @decision = Decision.find(params[:decision_id])
    @participation = Participation.new
    @participations = @decision.participations
  end

  def create
    user = User.find_by_email(params[:participation][:user])
    if user
      @decision = Decision.find(params[:decision_id])
      QueryService.add_user(@decision, user)
    else
      # create error to be displayed on form to say user not found
      flash.now[:error] = "User not found! Please try again."
    end
    redirect_to new_decision_participation_path(@decision)
  end

  def destroy
    p @participation = Participation.find(params[:id])
    p @decision = Decision.find(params[:decision_id])


    if @decision.proposals

    @participation.destroy
    redirect_to user_decisions_path(current_user.id)
  end
end
