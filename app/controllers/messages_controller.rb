class MessagesController < ApplicationController
  def create
    room = Room.find(params[:room_id])
    user = current_user
    @message = user.messages.build(message_params)
    respond_to do |format|
      if @message.save
        room.update_attributes(posted_at: @message.created_at)
        room.send_notification(message: @message, send_user: user)
        format.html { redirect_to room}
        format.js
      else
      end
    end
  end

  def destroy
    message = Message.find(params[:id])
    room = message.room
    if message.destroy
      flash[:success] = "メッセージを削除しました"
    else
      flash[:danger] = "メッセージを削除できませんでした"
    end
    redirect_to room
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
  
end