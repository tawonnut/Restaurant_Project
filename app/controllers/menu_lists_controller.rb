class MenuListsController < ApplicationController

  def index
  end 
  
  def drinking
  end 

  def menu_lists
  	@drinking = Drinking.all
  	@dessert = Dessert.all
  	@dish = Dish.all
  end
end
