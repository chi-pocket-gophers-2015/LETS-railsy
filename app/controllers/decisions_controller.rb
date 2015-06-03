class DecisionsController < ApplicationController

  def index

    @user = User.find(params[:user_id])
    @user_decisions = @user.decisions.where(is_active: true)
    # puts "============================= #{@user_decisions.pluck(:context)}"

    # @participations
  end

  def show
    @decision = Decision.find(params[:id])
    if @decision.is_active?
      # @participations = @decision.participations
      @current_proposal = @decision.proposals.find_by(status: "open")
      @current_query = @current_proposal.current_open_query
      @on_deck = @current_proposal.not_yet_voted - [@current_query.participation]
      @already_voted = @current_proposal.already_voted
      # @current_voter = @decision_participants[0]
    else
      @current_proposal = @decision.proposals.approved.first
    end
  end

  def new
    @decision = Decision.new
  end

  def create
    @decision = QueryService.create_decision(context: decision_params[:context])
    ProcessExpiredQueries.perform_async(@decision)
    QueryService.add_user(@decision, current_user)

    if @decision.valid?
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
