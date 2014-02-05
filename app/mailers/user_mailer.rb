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

  def user_registration_denied(user)
    @user = user
    mail(to: @user.email, :subject => 'Your registration has been denied')
  end

  def user_registration_approved_to_admin(user, admin)
    @user = user
    @admin = admin
    mail(to: @admin.email, :subject => "You approved #{user.full_name} registration")
  end

  def user_registration_denied_to_admin(user, admin)
    @user = user
    @admin = admin
    mail(to: @admin.email, :subject => "You denied #{@user.full_name} registration")
  end

  def invitation(user)
    @user = user
    mail(to: @user.email, :subject => "You have been invited to International G&T web platform")
  end

  def invitation_to_admin(user, admin)
    @user = user
    @admin = admin
    mail(to: @admin.email, :subject => "You sent invitation to #{user.full_name}")
  end

  def welcome(user)
    @user = user
    mail(to: @user.email, :subject => "Welcome to International G&T web platform")
  end
end
