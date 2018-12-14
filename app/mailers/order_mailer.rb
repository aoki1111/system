class OrderMailer < ApplicationMailer
  
  def shipment_notification(order:,buyer_address:,sending_address:nil,product:,postage:)
    @order = order
    @buyer_address = buyer_address
    if sending_address.nil?
      @sending_address = buyer_address
    else
      @sending_address = sending_address
    end
    @postage = postage
    @product = product
    mail to: @buyer_address.email, subject: "ご注文商品の発送のお知らせ"
  end
end
