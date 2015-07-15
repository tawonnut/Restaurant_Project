class KitchensController < ApplicationController
 
	def dish_kitchen
		@check = params[:check_value]
		if @check != nil
			@kitchen = Kitchen.new()
		    @check.each do |list|
		    	@menu = MenuList.where(:id => list.to_s)
		    	@menu.update(kitchen_id: @kitchen.id )
		    end 

		@menu = MenuList.where(kitchen_id: @kitchen.id)  
		end  
	end

	def dessert_kitchen
		@check = params[:check_value]
		require "pp"
		if @check != nil
			@kitchen = Kitchen.new()
		    @check.each do |list|
		    	@menu = MenuList.where(:id => list.to_s)
		    	@menu.update(kitchen_id: @kitchen.id )
		    end 

		@menu = MenuList.where(kitchen_id: @kitchen.id)  
		end  

	end

	def drinking_kitchen
		@check = params[:check_value]
		require "pp"
		if @check != nil
			@kitchen = Kitchen.new()
		    @check.each do |list|
		    	@menu = MenuList.where(:id => list.to_s)
		    	@menu.update(kitchen_id: @kitchen.id )
		    end 

		@menu = MenuList.where(kitchen_id: @kitchen.id)  
		end  

	end
	
end
