class ProposalsController < ApplicationController

  WAIT_TIME = 15 * 60 #for converting time from seconds to minutes

  def new
    @decision = Decision.find(params[:decision_id])
  end


  def create
    @decision = Decision.find(params[:decision_id])
    participation = Participation.find_by(user: current_user, decision: @decision)
    prop = Proposal.new(proposed_idea: params[:proposal][:proposed_idea], participation: participation)
    if prop.save
      prop.queries.create(participation: participation, status: "yes", respond_by: Time.now + WAIT_TIME, responded_at: Time.now)
      # prop.queries.create(participation:
      ## render...
    else
      # create an error to be displayed on the
      redirect_to new_decision_proposal_path(@decision)
    end
    redirect_to decision_path(@decision)
  end


  def update
    prop = Proposal.find_by(id: params[:proposal_id])

    prop.update_attributes(status: params[:status])
    # render
  end
end
