class TransactionsController < ApplicationController
  def create
#  	roast  = Roast.find_by!(slug: params[:slug])
#	order  = Order.find_by!(slug: params[:slug])
	sale = current_order.sales.create(
		amount: current_order.subtotal,
		buyer_email: current_user.email,
#		seller_email: roast.user.email,
		stripe_token: params[:stripeToken])
	sale.process!
	if sale.finished?
		redirect_to pickup_url(guid: sale.guid), notice: "Transaction Successful"
	else
		redirect_to roast_path(roast), notice: "Something went wrong"
	end
  end
 
  def pickup
    @sale = Sale.find_by!(guid: params[:guid])
    @roast = @sale.roast
    @order = @sale.order
#    @order_items = @sale.order_items
  end
end
