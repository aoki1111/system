class RoomsController < ApplicationController
  before_action :admin_user?, only: [:create]
  before_action :correct_room?, only: [:show]

  def index
    @user = current_user
    @rooms = @user.rooms.preload(:order_product, {order_product: :order_list}, {:order_product => {order_list: :buyer_address}}).order("posted_at DESC")
  end

  def show
    @user = current_user
    @room = Room.find(params[:id])
    @order_product = @room.order_product
    @product = @order_product.product
    @buyer_address = @order_product.order_list.buyer_address
    if @buyer_address.same_sending_address
      @sending_address = @buyer_address
    else
      @sending_address = @order_product.order_list.sending_address
    end
    @messages = @room.messages.preload(:user).order("created_at ASC")
    @message = Message.new
    room_manager = @room.room_managers.find_by(user_id: @user.id)
    room_manager.update_attributes(accessed_at: Time.now)
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
