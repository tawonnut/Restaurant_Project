class DrinkingsController < ApplicationController

	def new
		@drinking = Drinking.new
	end

	def update
    @restuarant= Restuarant.find(params[:id])
    @drinking = Drinking.new(drinking_name: params[:drinking_name],drinking_price: params[:drinking_price],restuarant_id: @restuarant.id)
    if @drinking.save
      flash[:notice] = "เพิ่มเมนูเรียบร้อยแล้ว"
      redirect_to restuarants_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
      redirect_to add_menu_restuarant_path

    end
  end
    end