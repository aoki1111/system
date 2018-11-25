class Admin::UsersController < Admin::ApplicationController
	def index
		@users = User.preload(:stocks,{stocks: :order_products}).paginate(page: params[:page], per_page: 10)
	end

	def show
		@user = User.find(params[:id])
		@order_products = ::EcData::OrderProduct.where(stock_id: @user.stock_ids).where(trailing_id: nil).order("bought_time DESC").paginate(page: params[:page], per_page: 10)
	end
	
	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to "index", flash: {success: "ユーザーの削除が完了しました"}
		else
			redirect_to "index", flash: {danger: "ユーザーの削除に失敗しました"}
		end
	end

	private

	def user_params
		params.require(:user).permit(:corporate_name, :lastname,:firstname, :lastname_phonetic, :firstname_phonetic, :email, :phone,:zipcode, :pref,:area,:city,:street,:building, :password, :password_confirmation)
	end

end
