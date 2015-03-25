class RestuarantsController < ApplicationController

def new
    
    @restuarant= Restuarant.new
  end

  def show
     @restuarant= Restuarant.find(params[:id])

  end
  def index
  	@restuarants= Restuarant.where(user_id: current_user.id).all
  end

def create

    @restuarant = Restuarant.new(restuarant_params)
    if @restuarant.save
      flash[:notice] = "Create is successfully"
      redirect_to restuarants_path
    else
      flash[:error] = "Error please fill in all field"
      redirect_to new_restuarant_path
    end
  end

def destroy
    @des= Restuarant.find(params[:id])
    @des.destroy
    flash[:notice] = "ลบเรียบร้อยแล้ว"
    redirect_to restuarants_path

end

def restuarant_params
    params.require(:restuarant).permit(:restuarant_name , :user_id)
  end


end

