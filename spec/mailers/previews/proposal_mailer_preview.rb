# Preview all emails at http://localhost:3000/rails/mailers/proposal_mailer

class ProposalMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  def notify_of_turn_to_vote
    @user = User.first
    @decision = Decision.first
    ProposalMailer.notify_of_turn_to_vote(@user, @decision)
  end

end
