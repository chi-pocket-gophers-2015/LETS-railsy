class DecisionsController < ApplicationController

  def index

    @user = User.find(params[:user_id])
    @user_decisions = @user.decisions.where(is_active: true)
    # puts "============================= #{@user_decisions.pluck(:context)}"

    # @participations
  end

  def show
    @decision = Decision.find(params[:id]).decisions
    # @participations = @decision.participations
    @proposal = @decision.proposals.where(status: open)
    @proposal_participations = @proposal.ordered_participations
  end

  def new
    @decision = Decision.new
  end

  def create
    @user = current_user
    @decision = @user.decisions.new(decision_params)

    if @decision.save
      Participation.create(user: @user, decision: @decision)
      redirect_to new_decision_participation_path(@decision)
    else
      errors
    end
  end

  private
  def decision_params
    params.require(:decision).permit(:context)
  end

end
