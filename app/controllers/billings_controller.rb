class BillingsController < ApplicationController

	def index
		@billing = Billing.where(restuarant_id: current_user.current_restuarant)

	end

	def show
		@billing = Billing.find(params[:id])
		@show_menu = MenuList.where(billing_id: @billing.id)
		@total = @show_menu.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
		@promotion = (@total.to_f * @promotion_discount.to_f)/100
	end

	def search_billing
		
	end	

end
