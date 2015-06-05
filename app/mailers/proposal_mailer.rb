class ProposalMailer < ApplicationMailer

  # In QueryService::create_query
  def notify_of_turn_to_vote(user, proposal, respond_by)
    @user = user
    @proposal = proposal
    @respond_by = respond_by
    mail(to: @user.email, subject: "LET'S - It's your turn, vote by #{@respond_by.strftime('%l:%M%P')}!")
  end

  # In QueryService::add_user
  def notify_of_invitation(user)
    @user = user
    mail(to: @user.email, subject: "LET'S - You're Invited!")
  end

  # In QueryService::close
  def notify_of_final_decision(user, decision)
    @user = user
    @decision = decision
    mail(to: @user.email, subject: "LET'S - You've Reached a Decision!")
  end

  #NEED TO ADD AFTER TIMING JOB SO GOES OUT WHEN SOMEONE MISSES TURN
  def notify_of_expired_time(user, decision)
    @user = user
    @decision = decision
    mail(to: @user.email, subject: "LET'S - You Missed Your Turn!")
  end

end
