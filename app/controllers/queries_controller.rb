class QueriesController < ApplicationController
  before_action :set_decision
  before_action :set_query

  def update
    case params[:status]
    when 'yes'
      QueryService.approve(@query, @current_participation)
      redirect_to decision_path(@decision)
    when 'no'
      QueryService.reject(@query)
      redirect_to new_decision_proposal_path(@decision)
    else
      raise ArgumentError, 'Query did not process properly.'
      # flash.now[:error] = "Query did not process properly."
    end
  end

  protected

  def set_decision
    @decision ||= Decision.find_by(id: params[:decision_id])
  end

  # def set_proposal
  #   @proposal ||= Proposal.find_by(id: params[:proposal_id])
  # end

  def set_query
    @query ||= Query.find_by(id: params[:id])
  end

  def set_current_participation
    @current_participation ||= Participation.find_by(user: current_user, decision: @decision)
  end
end
