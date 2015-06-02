class DecisionController < ApplicationController

  def index
    @decisions = User.find(params[:user_id]).decisions.where(is_active: true)
  end

  def show
    @decision = Decision.find(params[:id]).decisions
  end

  # def activeproposal

  # end

  def create
    @user = User.find(params[:user_id])
    @decision = @user.decisions.new(decision_params)

    if @decision.save
      Participation.create(user: @user, decision: @decision)
    else
      errors
    end
  end

  private
  def decision_params
    params.require(:decision).permit(:context)
  end

end
