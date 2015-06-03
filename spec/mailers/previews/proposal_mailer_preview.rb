# Preview all emails at http://localhost:3000/rails/mailers/proposal_mailer

class ProposalMailerPreview < ActionMailer::Preview

# http://localhost:3000/rails/mailers/proposal_mailer

  def notify_of_turn_to_vote
    user = User.first
    # mail(to: user.email, subject: "LET'S - It's Your Turn to Vote!")
    ProposalMailer.notify_of_turn_to_vote(user)
  end

  def notify_of_invitation
    user = User.first
    # mail(to: @user.email, subject: "LET'S - You're Invited!")
    ProposalMailer.notify_of_invitation(user)
  end

  def notify_of_final_decision
    user = User.first
    decision = Decision.first
    # mail(to: @user.email, subject: "LET'S - You've Reached a Decision!")
    ProposalMailer.notify_of_final_decision(user, decision)
  end

  def notify_of_expired_time
    user = User.first
    decision = Decision.first
    # mail(to: @user.email, subject: "LET'S - You Missed Your Turn!")
    ProposalMailer.notify_of_expired_time(user, decision)
  end

end
