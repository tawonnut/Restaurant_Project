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
    @restuarant= Restuarant.find(params[:id])
    @user = User.new(email: params[:email],name: "N/A",surname: "N/A",tel: "N/A",
      password: "", password_confirmation:"")
    random_password = Devise.friendly_token

    @user.password = random_password
    @user.password_confirmation = random_password

    if @user.save
      @user.send_reset_password_instructions
      @restuarant.create_staff(@user.id,@restuarant.id)
      flash[:notice] = "สร้างยูสเซอร์สำเร็จแล้ว"
      redirect_to restuarant_path(@restuarant.id)
    else
      flash.now[:error] ||= []
      flash[:error] = "ll"
      flash[:error] << @user.errors.full_messages.uniq.join(', ')
      redirect_to restuarant_path(@restuarant.id)
    end
end

  def show_staff
     @restuarant= Restuarant.find(params[:id])
     @membership= Membership.where(restuarant_id: @restuarant.id)


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

