class BuyerAddress < EcData::Address
	self.primary_key = "id"
	belongs_to :order_list, class_name:"EcData::OrderList"

	def shipment_date
		self.desired_delivery_date.strftime('%Y年%m月%d日')
	end

	def shipment_time
		if desired_delivery_time == 0
			return "時間帯指定なし"
		elsif desired_delivery_time == 1
			return "午前中指定"
		elsif desired_delivery_time == 3
			return "14時〜16時指定"
		elsif desired_delivery_time == 4
			return "16時〜18時指定"
		elsif desired_delivery_time == 5
			return "18時〜20時指定"
		elsif desired_delivery_time == 7
			return "19時〜21時指定"
		else
			return "不正なパラメータ"
		end
	end
end
