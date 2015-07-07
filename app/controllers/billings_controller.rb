class BillingsController < ApplicationController

	def index_show
		@restuarant_show = Restuarant.where(id: current_user.current_restuarant).first
    	@restuarant_user = Restuarant.where(user_id: current_user.id) 
    	@restuarant= Restuarant.where(id: current_user.current_restuarant).first
		date_start = params[:date_start]
		date_end = params[:date_end]
		if date_start != nil && date_end !=nil
			@billing = Billing.where(:date.gte => date_start, :date.lte => date_end)
		else
			@billing = Billing.where(restuarant_id: current_user.current_restuarant)
		end
   
		 respond_to do |format|
		 	format.html
		 	format.csv { send_data @billing.to_csv, filename: "Report-#{Date.today}.csv"}
		 end
	end

	def show
		@billing = Billing.find(params[:id])
		@show_menu = MenuList.where(billing_id: @billing.id)
		@total = @show_menu.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
		@promotion = (@total.to_f * @promotion_discount.to_f)/100
	end

	def report
		@restuarant_show = Restuarant.where(id: current_user.current_restuarant).first
    	@restuarant_user = Restuarant.where(user_id: current_user.id) 
    	@restuarant = Restuarant.where(id: current_user.current_restuarant).first
		@report = MenuList.where(restuarant_id: current_user.current_restuarant)
	end
end
