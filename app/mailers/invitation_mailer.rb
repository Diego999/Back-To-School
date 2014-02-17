class InvitationMailer < ActionMailer::Base
  default from: "marco.aeberli@he-arc.ch"
  def invitation_email(user)
    @user = user
    @url  = 'http://www.he-arc.ch'
    mail(to: @user.email, subject: 'Your invitation to Back-to-School')
  end
end
