class DishsController < ApplicationController

	def new
		@dish = Dish.new
	end

  def show
    @restuarant_show = Restuarant.find(params[:id])
    @restuarant_user = Restuarant.where(user_id: current_user.id) 
    @restuarant= Restuarant.find(params[:id])
    @dish = Dish.where(restuarant_id: @restuarant.id)
    @dishs = Dish.new
  end

  def edit
    @dish= Dish.find(params[:id])
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

  def update_dish
      @dish= Dish.find(params[:id])
      @restuarant= Restuarant.where(_id: @dish.restuarant_id)
    if @dish.update(dish_name: params[:dish][:dish_name],dish_price: params[:dish][:dish_price])
      flash[:notice] = "แก้ไขเมนูเรียบร้อยแล้ว"
      redirect_to  dish_path(@restuarant[0].id)
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
       redirect_to dish_path
    end
  end

  def destroy
      @dish= Dish.find(params[:id])
      @restuarant= Restuarant.where(_id: @dish.restuarant_id)
      @dish.destroy
      flash[:notice] = "ลบเมนูเรียบร้อยแล้ว"
      redirect_to dish_path(@restuarant[0].id)

  end

    def dish_search
    @dish_name = params[:dish_name]  
    dish = Dish.all
      if @dish_name != ""
        @dish = dish.inject([]) do |name,dish|
          if dish.dish_name.include?(@dish_name)
            name << dish
          end 
            name
        end
        render json: @dish
      else
        render json: @dish
      end
  end  

end
