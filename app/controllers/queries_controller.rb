class QueriesController < ApplicationController


  # def create
  #   q = Query.new(participation_id: params[:participation_id], status: params[:status] )

  #   if save
  #     responded_at = Time.now
  #   else

  #   end

  #   end

  # end

  # this update route only happens in the middle of a decision, upon calling this route, the next_participation_id needs to also be part of the params

  def update
    query = Query.update_attributes(status: params[:status])

    if query.status == "no"

      query.proposal.update_attributes(status: "refused")

      new_prop = Proposal.create(status: "open", proposed_idea: params[:proposed_idea], participation_id: params[:participation_id])

    end
  end
end
