class Admin::PostagesController < Admin::ApplicationController
	before_action :admin_execute, only: [:update]

	def index
		@user = User.find(params[:user_id])
		@postages = user.postages.paginate(page: params[:page], per_page: 10)
	end

	def edit
		@postage = Postage.find(params[:id])
	end

	def update
		@postage = Postage.find(params[:id])
		if @postage.update_attributes(postage_params)
			redirect_to root_path
		else
			flash[:danger] = "編集に失敗しました。"
			render 'edit'
		end
	end

end
