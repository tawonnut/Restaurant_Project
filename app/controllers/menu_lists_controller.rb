class MenuListsController < ApplicationController

  def index
  end 
  
  def show
    @table = Table.find(params[:id])
    @show_menu = MenuList.where(table: @table.id.to_s)
  end

  def create  
    require "pp"
    pp "lllllllllllllllllllllllllllllllllllllllllllllllllll"
    pp create_params
    pp "dl;kfsl;kfsl;k;'fkaskfsk;'askdf"
    @menu = MenuList.new(create_params)
      if @menu.save
        respond_to do |format|
          format.html do
            flash[:notice] = "สร้างเรียบร้อยแล้ว"
            redirect_to properties_path 
          end
          format.json do
            render status: :created, json: @menu.ng_json
          end
        end  
      
      else
        respond_to do |format|
          format.html do
            flash[:error] = "ข้อมูลไม่ถูกต้อง กรุณากรอกใหม่"
            render action: "new"

          end
          format.json do


            render json: {error: @errors_menu}
          end
        end 
      end  
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

#   def dessert_search
#     @dessert_name = params[:dessert_name]  
#     dessert = Dessert.all
#       if @dessert_name != ""
#         @dessert = dessert.inject([]) do |name,dessert|
#           if dessert.dessert_name.include?(@dessert_name)
#             name << dessert
#           end 
#             name
#         end
#         render json: @dessert
#       else
#         render json: @dessert
#       end
#   end

# def drinking_search
#     @drinking_name = params[:drinking_name]  
#     drinking = Drinking.all
#       if @drinking_name != ""
#         @drinking = drinking.inject([]) do |name,drinking|
#           if drinking.drinking_name.include?(@drinking_name)
#             name << drinking
#           end 
#             name
#         end
#         render json: @drinking
#       else
#         render json: @drinking
#       end
#   end

  def menu_lists
  	@drinking = Drinking.all
  	@dessert = Dessert.all
  	@dish = Dish.all
  end
end

    def create_params
      params.require(:menu_list).permit(:menu,:value,:remark,:menu_type,:table_id)
    end