class UserMailer < ActionMailer::Base
  default from: "noreply@service.com"

  def confirmation(user)
  	@user = user
  	mail(to: @user.email, :subject => 'Registration confirmation')
  end

  def approval(admins)
  	@admins = admins
  	admin_mails = @admins.collect(&:email).join(',')
  	mail(to: admin_mails, :subject => 'User registration approval pending')
  end
end
