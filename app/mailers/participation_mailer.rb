class ParticipationMailer < ApplicationMailer

  def invite_friend(name, email)
    @name = name
    mail(to: email, subject: "LET'S - You're Invited!")
  end

end
