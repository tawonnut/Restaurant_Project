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

  def dessert_search
    @dessert_name = params[:dessert_name]  
    dessert = Dessert.all
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

def drinking_search
    @drinking_name = params[:drinking_name]  
    drinking = Drinking.all
      if @drinking_name != ""
        @drinking = drinking.inject([]) do |name,drinking|
          if drinking.drinking_name.include?(@drinking_name)
            name << drinking
          end 
            name
        end
        render json: @drinking
      else
        render json: @drinking
      end
  end

  def menu_lists
  	@drinking = Drinking.all
  	@dessert = Dessert.all
  	@dish = Dish.all
  end
end
