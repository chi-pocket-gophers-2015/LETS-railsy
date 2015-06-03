class ProposalMailer < ApplicationMailer

  def notify_of_turn_to_vote(user)
    @user = user
    # @decision = decision
    mail(to: @user.email, subject: "LET'S - It's Your Turn to Vote!")
  end

  def invitation_notification(user)
    @user = user
    mail(to: @user.email, subject: "LET'S - You're Invited!")
  end

  def decision_made_notification(user)
    @user = user
    mail(to: @user.email, subject: "LET'S - You've Reached a Decision!")
  end

  def time_expired_notification(user)
    @user = user
    mail(to: @user.email, subject: "LET'S - You Missed Your Turn!")
  end


end
