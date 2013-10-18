class EventNotifier < ActionMailer::Base
  default from: "service@internationalgt.ro"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notifier.confirmation.subject
  #

  def confirmation(event, machine)
    @greeting = "Hi"
    @event = event
    @machine = machine
    mail to: "mentor.1985@gmail.com", subject: 'Just testing event confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notifier.notification.subject
  #
  def notification(event, machine)
    @greeting = "Hi"
    @event = event
    @machine = machine
    mail to: "mentor.1985@gmail.com", subject: 'Just testing event notification'
  end
end
