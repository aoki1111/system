class StaticPagesController < ApplicationController
	before_action :logged_in_user, only: [:dashboard]
	require 'date'

	def home
	end

	def help
	end

	def company
	end

	def privacy
	end

	def introducing
	end

	def dashboard
		stock_ids = Stock.where(user_id:current_user.id).pluck(:id)
		unship_order = EcData::OrderProduct.eager_load(:order_list, :product, {order_list: :payment},{order_list: :buyer_address}, {order_list: :sending_address}).where(stock_id:stock_ids).where(trailing_id:nil).where(:order_list => {:payments => {paid: true}})
		@dashboard_order = unship_order.where(:order_list => {:addresses => {desired_delivery: false}}).order("order_products.bought_time DESC")
		@delivery_desired_order = unship_order.where(:order_list => {:addresses => {desired_delivery: true}}).order("addresses.desired_delivery_date ASC")
	end

	def search_unship_order
		stock_ids = Stock.where(user_id:current_user.id).pluck(:id)
		unship_order = EcData::OrderProduct.eager_load(:order_list, :product, {order_list: :payment},{order_list: :buyer_address}, {order_list: :sending_address}).where(stock_id:stock_ids).where(trailing_id:nil).where(:order_list => {:payments => {paid: true}}).order("order_products.bought_time DESC")
		if params["name"].present?
			unship_order = unship_order.where("addresses.lastname LIKE ?","%#{params['name']}%").distinct
		end
		if params["use_date"] == "true"
			if params["start"].present? && params["end"].present?
				start_date = params["start"].to_time
				end_date = params["end"].end_of_day
			elsif params["start"].present?
				start_date = params["start"].to_time
				end_date = start_date.end_of_day + 1.month
			elsif params["end"].present?
				end_date = params["end"].to_time.end_of_day
				start_date = end_date - 1.month
			end
			unship_order = unship_order.where(bought_time:start_date..end_date)
		end
		@dashboard_order = unship_order.where(:order_list => {:addresses => {desired_delivery: false}})
		@delivery_desired_order = unship_order.where(:order_list => {:addresses => {desired_delivery: true}})
		render :action => "dashboard"
	end

	def shipments
	end

	def record
	end

	def gap
	end

end
