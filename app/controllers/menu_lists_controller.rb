class MenuListsController < ApplicationController

  def index
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





  def drinking
  end 

  def menu_lists
  	@drinking = Drinking.all
  	@dessert = Dessert.all
  	@dish = Dish.all
  end
end
