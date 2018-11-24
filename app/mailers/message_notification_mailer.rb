class MessageNotificationMailer < ApplicationMailer

  def new_message(message:, send_user:, received_user:)
    @message = message
    @room = message.room
    @send_user = send_user
    @received_user = received_user
    mail to: @received_user.email, subject: "新規メッセージがあります"
  end

end
