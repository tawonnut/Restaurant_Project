class RestuarantsController < ApplicationController

def new
    @restuarant= Restuarant.new
  end

  def show
      @restuarant= Restuarant.find(params[:id])
      @user = User.where(restuarant_id: @restuarant.id)  
  end

  def staff
    @restuarant= Restuarant.find(params[:id])
    @users = User.where(restuarant_id: @restuarant.id)
  end


  def index
  	@restuarants= Restuarant.where(user_id: current_user.id).all
  end

def create
    @restuarant = Restuarant.new(restuarant_params)
    if @restuarant.save
      @restuarant.create_owner(current_user.id,@restuarant.id)
      flash[:notice] = "สร้างร้านใหม่เรียบร้อยแล้ว"
      redirect_to restuarants_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
      redirect_to new_restuarant_path
    end
  end

def destroy
    @des= Restuarant.find(params[:id])
    @des.destroy
    flash[:notice] = "ลบเรียบร้อยแล้ว"
    redirect_to restuarants_path

end

def add_staff
  @user = User.new
end


  def add_drinking
    @drinking= Restuarant.find(params[:id])
  end

  def add_dessert
    @dessert = Restuarant.find(params[:id])
  end

  def add_dish
    @dish = Restuarant.find(params[:id])
  end


  def restuarant_params
    params.require(:restuarant).permit(:restuarant_name , :user_id)
  end

  
  def drinking_params
    params.require(:drinking).permit(:drinking_name, :restuarant_id)
  end

  def dessert_params
    params.require(:dessert).permit(:dessert_name, :restuarant_id)
  end

  def dish_params
    params.require(:dish).permit(:dish_name, :restuarant_id)
  end

end

