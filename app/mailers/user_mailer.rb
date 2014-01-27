class UserMailer < ActionMailer::Base
  default from: "noreply@service.com"

  def confirmation(user)
  	@user = user
  	mail(to: @user.email, :subject => 'Registration confirmation')
  end

  def approval(admins, new_user)
  	@admins = admins
    @user = new_user
  	admin_mails = @admins.collect(&:email).join(',')
  	mail(to: admin_mails, :subject => 'Pending new user confirmation')
  end

  def user_registration_approved(user)
    @user = user
    mail(to: @user.email, :subject => 'Your registration has been approved')
  end
end
