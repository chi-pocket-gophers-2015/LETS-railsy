class ProposalMailer < ApplicationMailer

  def notify_of_turn_to_vote(user)
    @user = user
    # @decision = decision
    mail(to: @user.email, subject: "LET'S - It's Your Turn to Vote!")
  end


end
