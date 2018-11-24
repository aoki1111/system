class Admin::RoomsController < ApplicationController
  before_action :admin_user?, only: [:create]
  before_action :correct_room?, only: [:show]

  def index
    @rooms = current_user.rooms
  end

  def create
    if @room = current_user.rooms.create(room_params)
      @room.room_managers.create(user_id: params[:user_id])
      redirect_to room_path(@room)
    else
      flash.now[:danger] = "メッセージスレッドの作成に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @room = current_user.room.find(params[:id])
    @messages = @room.messages
  end

  private

  def room_params
    params.require(:room).permit(:order_product_id)
  end

  def correct_user?
    access_destination_user = User.find(params[:user_id])
    return current_user ==  access_destination_user
  end

  def correct_room?
    room = Room.find(params[:id])
    return room.users.exists?(id:current_user.id)
  end

  def admin_user?
		if current_user.admin
			return true
		else
			redirect_to root_path
		end
	end
end
