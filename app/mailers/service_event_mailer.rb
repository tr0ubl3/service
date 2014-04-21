class ServiceEventMailer < ActionMailer::Base
  default from: "service@internationalgt.ro"

  def open(event)
  	@event = event
  	admin_mails = User.admins.collect(&:email).join(',')
  	mail to: admin_mails, subject: "#{@event.event_name} is open"
  end
end
