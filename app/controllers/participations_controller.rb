class ParticipationsController < ApplicationController
  def new
    @decision = Decision.find(params[:decision_id])
    @participation = Participation.new
    @participations = @decision.participations
  end

  def create
    user = User.find_by_email(params[:participation][:user])
    # participation = Participation.find_by(user_id: user.id)

    # puts participation.validate

    @decision = Decision.find(params[:decision_id])

    if user
     if !user.decisions.include? @decision
        QueryService.add_user(@decision, user)
        redirect_to new_decision_participation_path(@decision)
      else
        flash[:error] = "You already added that friend!"
        redirect_to new_decision_participation_path(@decision)
      end
    else
      flash[:error] = "User not found! Please try again."
      redirect_to new_decision_participation_path(@decision)
    end
  end
end
