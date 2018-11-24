# Preview all emails at http://localhost:3000/rails/mailers/message_notification_mailer
class MessageNotificationMailerPreview < ActionMailer::Preview
  def new_message
    send_user = User.first
    received_user = User.second
    message = send_user.messages.first
    MessageNotificationMailer.new_message(message: message, send_user: send_user, received_user: received_user)
  end
end
