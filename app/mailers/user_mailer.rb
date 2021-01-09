class UserMailer < ApplicationMailer
    default from: 'Somebody <donotreply@example.com>'

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/users/activate?activation_token=#{@user.activation_token}"
    mail(to: "#{user.email} <#{user.email}>", subject: 'Activate your account!')
  end

end
