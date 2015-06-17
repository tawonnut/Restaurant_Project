class DessertsController < ApplicationController


	def new
		@dessert = Dessert.new
	end

  def show
    @restuarant_show = Restuarant.find(params[:id])
    @restuarant_user = Restuarant.where(user_id: current_user.id) 
    @restuarant= Restuarant.find(params[:id])
    @dessert = Dessert.where(restuarant_id: @restuarant.id)
    @desserts = Dessert.new
  end

  def edit
    @dessert= Dessert.find(params[:id])
  end

	def update
    @restuarant= Restuarant.find(params[:id])
    @dessert = Dessert.new(dessert_name: params[:dessert_name],dessert_price: params[:dessert_price],restuarant_id: @restuarant.id)
    if @dessert.save
      flash[:notice] = "เพิ่มเมนูเรียบร้อยแล้ว"
      redirect_to  dessert_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
      redirect_to add_dessert_restuarant_path
    end
  end

  def update_dessert
      @dessert= Dessert.find(params[:id])
      @restuarant= Restuarant.where(_id: @dessert.restuarant_id)
    if @dessert.update(dessert_name: params[:dessert][:dessert_name],dessert_price: params[:dessert][:dessert_price])
      flash[:notice] = "แก้ไขเมนูเรียบร้อยแล้ว"
      redirect_to  dessert_path(@restuarant[0].id)
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
       redirect_to dessert_path
    end
  end

  def destroy
    @dessert= Dessert.find(params[:id])
    @restuarant= Restuarant.where(_id: @dessert.restuarant_id)
    @dessert.destroy
    flash[:notice] = "ลบเมนูเรียบร้อยแล้ว"
    redirect_to dessert_path(@restuarant[0].id)
  end

  def dessert_search
    @dessert_name = params[:dessert_name]  
    dessert = Dessert.where(restuarant_id: current_user.current_restuarant)
      if @dessert_name != ""
        @dessert = dessert.inject([]) do |name,dessert|
          if dessert.dessert_name.include?(@dessert_name)
            name << dessert
          end 
            name
        end
        render json: @dessert
      else
        render json: @dessert
      end
  end  
end
