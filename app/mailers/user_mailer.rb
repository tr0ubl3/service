class UserMailer < ActionMailer::Base
  default from: "noreply@service.com"

  def confirmation(user)
  	@user = user
  	mail(to: @user.email)
  end
end
