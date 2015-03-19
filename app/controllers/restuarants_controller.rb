class RestuarantsController < ApplicationController

def new
    
    @restuarant= Restuarant.new
  end

  def show
     @restuarant= Restuarant.find(params[:id])

  end
  def index
  	@restuarants= Restuarant.all
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

def restuarant_params
    params.require(:restuarant).permit(:restuarant_name)
  end


end

