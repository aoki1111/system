class PasswordResetsController < ApplicationController
	before_action :get_user,   only: [:edit, :update]
	before_action :valid_user, only: [:edit, :update]
	
	def new
	end
	
	def edit
	end
	
	def create
		@user = User.find_by(email: params[:password_reset][:email].downcase)
		if @user
			@user.create_reset_digest
			@user.send_password_reset_email
			flash[:info] = "パスワードリセット用のメッセージを送信しました。"
			redirect_to root_url
		else
			flash.now[:danger] = "メールアドレスが存在しませんでした。"
			render 'new'
		end
	end
	
	def update
		if params[:user][:password].empty?
			@user.errors.add(:password, :blank)
			render 'edit'
		elsif @user.update_attributes(user_params)
			log_in @user
			@user.update_attribute(:reset_digest, nil)
			flash[:success] = "パスワードの更新が完了しました！"
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	private
	
	def user_params
		params.require(:user).permit(:password, :password_confirmation)
	end
	
	def get_user
		@user = User.find_by(email: params[:email])
	end
	
	def valid_user
		unless (@user && @user.activated? &&
			@user.authenticated?(:reset, params[:id]))
			redirect_to root_url
		end
	end
	
	def check_expiration
		if @user.password_reset_expired?
			flash[:danger] = "パスワードリセットの有効期間が切れました。"
			redirect_to new_password_reset_url
		end
	end
	
end
