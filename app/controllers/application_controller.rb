class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :sidebar_unread_count
	include SessionsHelper

	def product_list
		list = EcData::Product.where(id:current_user.product_items.pluck(:product_id)).pluck(:name,:id)
		return list
	end

	def sidebar_unread_count
		@unread_counts = Room.unread_total(current_user)
	end

	# 例外ハンドル
	unless Rails.env.development?
		rescue_from Exception,                        with: :_render_500
		rescue_from ActiveRecord::RecordNotFound,     with: :_render_404
		rescue_from ActionController::RoutingError,   with: :_render_404
	end
	
	def routing_error
		raise ActionController::RoutingError, params[:path]
	end

	private

  def _render_404(e = nil)
		logger.info "Rendering 404 with exception: #{e.message}" if e
		if request.format.to_sym == :json
	  	render json: { error: '404 error' }, status: :not_found
		else
			render 'errors/404', status: :not_found
		end
  end

  def _render_500(e = nil)
		logger.error "Rendering 500 with exception: #{e.message}" if e
		if request.format.to_sym == :json
			render json: { error: '500 error' }, status: :internal_server_error
		else
			render 'errors/500', status: :internal_server_error
		end
	end
	
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "ログインをしてください。"
			redirect_to login_path
		end
	end

end
