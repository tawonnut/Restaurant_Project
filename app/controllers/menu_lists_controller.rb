class MenuListsController < ApplicationController

  def index
  end 
  
  def show
    @promotion = Promotion.new
    @table = Table.find(params[:id])
    @show_dish = MenuList.where(table: @table.id.to_s,menu_type: "อาหารคาว")
    @show_dessert = MenuList.where(table: @table.id.to_s,menu_type: "อาหารหวาน")
    @show_drink = MenuList.where(table: @table.id.to_s,menu_type: "เครื่องดื่ม")
  end

  def create  
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

  def edit
    @menu = MenuList.find(params[:id])
  end         

  def update
    @menu = MenuList.find(params[:id])
   if  @menu.update(menu: params[:name],remark: params[:remark], menu_type: params[:type],value: params[:value])
    flash[:notice] = "เเก้ไขเมนูอาหารเรียบร้อยเเล้ว"
    redirect_to menu_list_path(@menu.table_id)
    else
      rander action"edit"
    end 
    
  end

  def destroy
    @menu = MenuList.find(params[:id])
    @menu.destroy
      respond_to do |format|
          format.html do
            flash[:notice] = "ลบเมนูอาหารเรียบร้อยเเล้ว"
            redirect_to menu_list_path(@menu.table_id)
          end
          # format.json do
          #   render json: {success: true}
          # end
        end 
  end

  def payment

    require "pp"
    @promotion_discount = params[:promotion][:promotion_discount]
    @table = Table.find(params[:id])
    @show_dish = MenuList.where(table: @table.id.to_s,menu_type: "อาหารคาว")
    @show_dessert = MenuList.where(table: @table.id.to_s,menu_type: "อาหารหวาน")
    @show_drink = MenuList.where(table: @table.id.to_s,menu_type: "เครื่องดื่ม")
    price_dish = @show_dish.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    price_dessert = @show_dessert.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    price_drink = @show_drink.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    @total = price_dish+price_dessert+price_drink
    @promotion = (@total.to_f * @promotion_discount.to_f)/100
  end

  # def menu_lists
  # 	@drinking = Drinking.all
  # 	@dessert = Dessert.all
  # 	@dish = Dish.all
  # end

  def create_params
    params.require(:menu_list).permit(:menu,:value,:remark,:menu_type,:table_id,:menu_price)
  end



end