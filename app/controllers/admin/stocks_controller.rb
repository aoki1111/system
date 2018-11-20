class Admin::StocksController < Admin::ApplicationController

	def index
		@user = User.find(params[:user_id])
		@stocks = @user.stocks.paginate(page: params[:page], per_page: 10)
	end

	def show
		@stock = Stock.find(params[:id])
	end
	
	def edit
		@stock = Stock.find(params[:id])
	end

	def update
		@stock = Stock.find(params[:id])
	end

	def new
		@user = User.find(params[:user_id])
		@stock = @user.stocks.build
	end

	def create
		@user = User.find(params[:user_id])
		@stock = @user.stocks.build
	end

	def destroy
	end

	private

	def stock_params
		params.require(:stock).permit(:pref,:area,:product_id,:quantity,:shipment_week,:remark)
	end

end