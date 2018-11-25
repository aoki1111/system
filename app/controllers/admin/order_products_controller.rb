class Admin::OrderProductsController < Admin::ApplicationController
  
  def index
    @farmer = User.find(params[:user_id])
    if params[:unship_order] == "true"
      @order_products = ::EcData::OrderProduct.eager_load(:order_list, {order_list: :buyer_address}, {order_list: :sending_address}, {order_list: :payment}).where(stock_id: @farmer.stock_ids).where.not(addresses: {desired_delivery: true}).where(trailing_id: nil).where(payments:{paid: true}).order("order_products.bought_time ASC").paginate(page: params[:page], per_page: 10)
    elsif params[:desired_delivery] == "true"
      @order_products = ::EcData::OrderProduct.eager_load(:order_list, {order_list: :buyer_address}, {order_list: :sending_address}, {order_list: :payment}).where(stock_id: @farmer.stock_ids).where(addresses: {desired_delivery: true}).where(payments:{paid: true}).where(trailing_id: nil).order("addresses.desired_delivery_date ASC").paginate(page: params[:page], per_page: 10)
    else
      @order_products = ::EcData::OrderProduct.eager_load(:order_list, {order_list: :buyer_address}, {order_list: :sending_address}, {order_list: :payment}).where(stock_id: @farmer.stock_ids).order("order_products.bought_time ASC").paginate(page: params[:page], per_page: 10)
    end
  end

  def edit
    @order_product = ::EcData::OrderProduct.find(params[:id])
    @farmer = @order_product.stock.user
    @farmer_stocks = @farmer.stocks.order("salable DESC")
    @product = @order_product.product
    @product_farmers = @order_product.product.users
    @buyer_address = @order_product.order_list.buyer_address
    unless @buyer_address.same_sending_address
      @sending_address = @order_product.order_list.sending_address
    else
      @sending_address = @buyer_address
    end
  end

  def update
    @order_product = ::EcData::OrderProduct.find(params[:id])
    @farmer = @order_product.stock.user
    if @order_product.update_attributes(op_params)
      flash[:success] = "注文情報の更新が完了しました"
      redirect_to admin_user_order_products_path(@farmer)
    else
      flash.now[:danger] = "注文情報の更新に失敗しました。"
      render 'new'
    end
  end

  def destroy
  end

  def update_shipment_week
    @farmer = User.find(params[:farmer_id].to_i)
    @farmer_stocks = @farmer.stocks.where(product_id:params[:product_id].to_i).order("salable DESC")
    render :partial => 'shipment_week'
  end

  private

  def op_params
    params.require(:ec_data_order_product).permit(:stock_id,:priority)
  end
end