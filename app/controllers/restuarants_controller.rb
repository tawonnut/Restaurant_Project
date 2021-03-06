class RestuarantsController < ApplicationController

  def new
    @restuarant= Restuarant.new
  end

  def show
    @restuarant_show = Restuarant.find(params[:id])
    @user = User.where(_id: current_user.id) 
    @user.update(current_restuarant: @restuarant_show.id) 
    @restuarant_user = Restuarant.where(user_id: current_user.id)  
    @restuarants = Restuarant.where(user_id: current_user.id)
    @table = Table.new
    @table_show = Table.where(restuarant_id: @restuarant_show.id).order(table_number: "aesc")
  end

  def staff
    @restuarant= Restuarant.find(params[:id])
    @users = User.where(restuarant_id: @restuarant.id)
    @restuarant_user = Restuarant.where(user_id: current_user.id).all 
  end

  def edit
  end

  def index
    @restuarant= Restuarant.new
    @user = User.where(_id: current_user.id) 
    @user.update(current_restuarant: nil)  
    @restuarants= Restuarant.where(user_id: current_user.id).all
  end

def create
    @restuarant = Restuarant.new(restuarant_params)
    if @restuarant.save
      @promotion = Promotion.new(promotion_name: "ไม่มีส่วนลด",promotion_discount: 0,restuarant_id: @restuarant.id)
      @promotion.save
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
    @restuarant = Restuarant.where(id: current_user.current_restuarant)
    @restuarant = @restuarant[0]
    @user = User.new(email: params[:email],name: "N/A",surname: "N/A",tel: "N/A",
      password: "", password_confirmation:"")
    random_password = Devise.friendly_token

    @user.password = random_password
    @user.password_confirmation = random_password

    if @user.save
      @user.send_reset_password_instructions
      @restuarant.create_staff(@user.id,@restuarant.id)
      flash[:notice] = "สร้างยูสเซอร์สำเร็จแล้ว"
      redirect_to show_staff_restuarant_path(@restuarant.id)
    else
      flash.now[:error] ||= []
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
      flash[:error] << @user.errors.full_messages.uniq.join(', ')
      redirect_to show_staff_restuarant_path(@restuarant.id)
    end
end

  def show_staff
     @membership= Membership.where(restuarant_id: current_user.current_restuarant)
     @restuarant_user = Restuarant.where(user_id: current_user.id) 
     @restuarant_show = Restuarant.where(id: current_user.current_restuarant)
     @restuarant_show = @restuarant_show[0]
  end  

  def destroy_staff
      @membership = Membership.find(params[:id])
      @user = User.where(id: @membership.user_id)
      @user.destroy
      @membership.destroy
      flash[:notice] = "ลบเรียบร้อยแล้ว"
      redirect_to show_staff_restuarant_path
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
    params.require(:restuarant).permit(:restuarant_name , :user_id , :legal_person , :restuarant_tel , :tax_id , :restuarant_address, :restuarant_owner,
      :province,:county,:district,:branch_id)
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

