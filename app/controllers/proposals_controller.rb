class ProposalsController < ApplicationController

  WAIT_TIME = 15 * 60


  def create
    prop = Proposal.new(status: 'open', proposed_idea: params[:proposed_idea], participation_id: params[:participation_id])

    user = User.find_by(id: params[:id])

    if prop.save
      Query.create(participation_id: params[:participation_id], status: "yes", respond_by: Time.now + WAIT_TIME)
      ## render...
    else
      ## raise error
      ## redirect
    end
  end


  def update
    prop = Proposal.find_by(id: params[:proposal_id])

    prop.update_attributes(status: params[:status])
    # render
  end
end
