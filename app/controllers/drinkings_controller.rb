class DrinkingsController < ApplicationController

	def new
		@drinking = Drinking.new
	end

	def create
    @drinking = Drinking.new(drinking_params)
    if @drinking.save
      flash[:notice] = "เพิ่มเมนูเรียบร้อยแล้ว"
      redirect_to restuarants_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
      redirect_to new_drinking_path
    end
  end


  def drinking_params
    params.require(:drinking).permit(:drinking_name, :drinking_price, :restuarant_id)
  end

end
