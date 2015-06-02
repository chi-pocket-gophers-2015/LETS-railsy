class ParticipationsController < ApplicationController

  def new
    @decision = Decision.find(params[:decision_id])
    @participation = Participation.new
    @participations = @decision.participations
  end

  def create
    @user = User.find_by_email(params[:participation][:user])
    @decision = Decision.find(params[:decision_id])
    if @user
      Participation.create(user:@user, decision:@decision)
      # clear the error
    else
      # create error to be displayed on form to say user not found
    end
    redirect_to new_decision_participation_path(@decision)
  end

end
