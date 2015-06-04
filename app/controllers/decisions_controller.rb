class DecisionsController < ApplicationController
    # before_action :user_decisions, only: [:index]
    # respond_to :html, :js


  def index
    @user = user
    @user_decisions = user_decisions
  end

  def show
    @decision = Decision.find(params[:id])
    if @decision.is_active?
      # @participations = @decision.participations
      @current_proposal = @decision.proposals.find_by(status: "open")
      unless @current_proposal.current_open_query.nil?
        @current_query = @current_proposal.current_open_query
        @already_voted = @current_proposal.already_voted
        @on_deck = @current_proposal.not_yet_voted - [@current_query.participation]
      else
        @decision.approve!
        @on_deck = []
      end
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

    if decision_params[:context] != ""
      QueryService.add_user(@decision, current_user)
    end

    if @decision.valid?
      redirect_to new_decision_participation_path(@decision)
    else
      flash.now[:error] = "We could not create your new decision; please try again."
      render(:new)
    end
  end


  private

  def user_decisions
    @user = user
    @user_decisions = @user.decisions.where(is_active: true).order(created_at: :desc)
  end

  def user
    @user = User.find(current_user)
  end

  def decision_params
    params.require(:decision).permit(:context)
  end

end
