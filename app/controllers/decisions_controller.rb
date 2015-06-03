class DecisionsController < ApplicationController

  def index

    @user = User.find(params[:user_id])
    @user_decisions = @user.decisions.where(is_active: true)
    # puts "============================= #{@user_decisions.pluck(:context)}"
    # @parti
    # @users_participations = @user.participations.select{|p| p.decision.is_active}
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
      p @current_user_participation = @decision.participations.where(user_id: current_user.id).first

    else
      @current_proposal = @decision.proposals.approved.first
    end
  end

  def new
    @decision = Decision.new
  end

  def create
    @decision = QueryService.create_decision(context: decision_params[:context])
    QueryService.add_user(@decision, current_user)

    if @decision.valid?
      redirect_to new_decision_participation_path(@decision)
    else
      flash.now[:error] = "We could not create your new decision; please try again."
    end
  end

  # def destroy
  #   puts "going down delete"
  #   puts params

  #   @decision = Decision.find(params[:id])
  #   @decision.destroy

  #   redirect_to user_decisions_path(current_user)
  # end

  private
  def decision_params
    params.require(:decision).permit(:context)
  end

end
