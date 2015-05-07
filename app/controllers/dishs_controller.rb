class DishsController < ApplicationController

	def new
		@dish = Dish.new
	end

  def show
    @restuarant= Restuarant.find(params[:id])
    @dish = Dish.where(restuarant_id: @restuarant.id)
  end

	def update
    @restuarant= Restuarant.find(params[:id])
    @dish = Dish.new(dish_name: params[:dish_name],dish_price: params[:dish_price],restuarant_id: @restuarant.id)
    if @dish.save
      flash[:notice] = "เพิ่มเมนูเรียบร้อยแล้ว"
      redirect_to  dish_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
      redirect_to add_dish_restuarant_path
    end
  end

  def destroy
      @dish= Dish.find(params[:id])
      @restuarant= Restuarant.where(_id: @dish.restuarant_id)
      @dish.destroy
      flash[:notice] = "ลบเมนูเรียบร้อยแล้ว"
      redirect_to dish_path(@restuarant[0].id)

  end
end
