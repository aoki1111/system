class Room < ApplicationRecord
	has_many :room_managers, dependent: :destroy
	has_many :users, through: :room_managers
	belongs_to :order_product, optional: :true, class_name:"EcData::OrderProduct"
	has_many :messages, dependent: :destroy
	
	class << self
		def unread_total(user)
			rooms = Room.eager_load(:room_managers, :messages).where(room_managers: {user_id: user.id}).distinct
			total = 0
			for room in rooms do
				unread = room.unread_count(user)
				total += unread
			end
			return total
		end
	end
	
	def send_notification(message:, send_user:)
		received_user = User.find(received_user_id(send_user.id))
		MessageNotificationMailer.new_message(message:message, send_user:send_user, received_user:received_user).deliver_now
	end
	
	def received_user_id(send_user_id)
		uids = user_ids
		uids.delete(send_user_id)
		return uids[0]
	end
	
	def room_name
		room_name = order_product.order_list.buyer_address.lastname + order_product.order_list.buyer_address.firstname
		return room_name
	end
	
	def last_sender
		messages.order("created_at DESC").first.user.corporate_name
	end
	
	def unread_count(user)
		current_room_manger = self.room_managers.find_by(user_id: user.id)
		unread = self.messages.where("created_at >= ?", current_room_manger.accessed_at).where.not(user_id: user.id).size
		return unread
	end
	
end
