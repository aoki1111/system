class Admin::ApplicationController < ApplicationController
	before_action :logged_in_user
	before_action :admin_user?

	private
	
	def admin_login
		authenticate_or_request_with_http_basic do |user, pass|
			if Rails.env == "development"
				user == "admin" && pass == "password"
			else
				user == ENV[ADMIN_LOGIN_NAME] && pass == ENV[ADMIN_LOGIN_PASSWORD]
			end
		end
	end

	def admin_execute
		authenticate_or_request_with_http_basic do |user, pass|
			if Rails.env == "development"
				user == "admin" && pass == "password"
			else
				user == ENV[ADMIN_EXECUTE_NAME] && pass == ENV[ADMIN_EXECUTE_PASSWORD]
			end
		end
	end

	def admin_user?
		if current_user.admin
			return true
		else
			redirect_to root_path
		end
	end
end
