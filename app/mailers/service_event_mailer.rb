class ServiceEventMailer < ActionMailer::Base
	add_template_helper(ApplicationHelper)
  default from: "service@internationalgt.ro"

  def open(event)
  	@event = event
  	admin_mails = User.admins.collect(&:email).join(',')
  	mail to: admin_mails, subject: "#{@event.event_name} is open"
  end

  def close(event)
  	@event = event
  	admin_mails = User.admins.collect(&:email).join(',')
  	mail to: admin_mails, subject: "#{@event.event_name} is closed"
  end
end
