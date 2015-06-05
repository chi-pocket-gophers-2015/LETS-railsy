class ProposalsController < ApplicationController
  before_action :set_decision
  before_action :set_current_participation

  def new
  end

  # def create
  #   if params[:proposal][:proposed_idea] != "" #&& Decision.find(params[:decision_id]).proposals.length == 0
  #     new_proposal = QueryService.create_proposal(@decision, @current_participation, params[:proposal][:proposed_idea])

  #     redirect_to decision_path(@decision)

  #   # elsif params[:proposal][:proposed_idea] != "" && Decision.find(params[:decision_id]).proposals.open.first.queries.find_by_participation(Participation.find_by(user_id: current_user.id, decision_id: params[:decision_id]).id).open?
  #   #   new_proposal = QueryService.create_proposal(@decision, @current_participation, params[:proposal][:proposed_idea])

  #   #   redirect_to decision_path(@decision)
  #   else
  #     flash.now[:error] = "Proposal must not be blank; please try again."
  #     render(:new)
  #   end
  # end

##############################################

  def create
    if params[:proposal][:proposed_idea] == ""
      flash.now[:error] = "Proposal must not be blank; please try again."
      render(:new)
    elsif @decision.proposals.length == 0
      new_proposal = QueryService.create_proposal(@decision, @current_participation, params[:proposal][:proposed_idea])
      redirect_to decision_path(@decision)
    elsif @current_participation.queries.last.open?
      new_proposal = QueryService.create_proposal(@decision, @current_participation, params[:proposal][:proposed_idea])
      redirect_to decision_path(@decision)
    else
      flash[:error] = "It is not your turn to propose an idea!"
      redirect_to decision_path(@decision)
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

# is this proposal the first proposal on the decision
