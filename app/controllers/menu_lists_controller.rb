class MenuListsController < ApplicationController

  def index
  end 
  
  def show
    @promotion = Promotion.new
    @table = Table.find(params[:id])
    @restuarant_show = Restuarant.where(id: @table.restuarant_id)
    @restuarant_show = @restuarant_show[0]
    @restuarant_user = Restuarant.where(user_id: current_user.id)
    @show_dish = MenuList.where(table: @table.id.to_s,menu_type: "อาหารคาว",billing_id: nil)
    @show_dessert = MenuList.where(table: @table.id.to_s,menu_type: "อาหารหวาน",billing_id: nil)
    @show_drink = MenuList.where(table: @table.id.to_s,menu_type: "เครื่องดื่ม",billing_id: nil)
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

  def cancle
    @menu = MenuList.find(params[:id])
    @menu.update(cancle: true ,kitchen_id: nil)
    flash[:notice] = "ยกเลิกเมนูอาหารเรียบร้อยเเล้ว"
    redirect_to menu_list_path(@menu.table_id)
  end

  # def destroy
  #   @menu = MenuList.find(params[:id])
  #   @menu.destroy
  #     respond_to do |format|
  #         format.html do
  #           flash[:notice] = "ลบเมนูอาหารเรียบร้อยเเล้ว"
  #           redirect_to menu_list_path(@menu.table_id)
  #         end
  #         # format.json do
  #         #   render json: {success: true}
  #         # end
  #       end 
  # end

  def payment
    @promotion_discount = params[:promotion][:promotion_discount]
    promotion = Promotion.where(promotion_discount: @promotion_discount.to_i)
    @table = Table.find(params[:id])
    @table.update(promotion_id: promotion[0].id)
    @show_dish = MenuList.where(table: @table.id.to_s,menu_type: "อาหารคาว",billing_id: nil ,:kitchen.ne => nil, cancle: false)
    @show_dessert = MenuList.where(table: @table.id.to_s,menu_type: "อาหารหวาน",billing_id: nil,:kitchen.ne => nil, cancle: false)
    @show_drink = MenuList.where(table: @table.id.to_s,menu_type: "เครื่องดื่ม",billing_id: nil,:kitchen.ne => nil, cancle: false)


    price_dish = @show_dish.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    price_dessert = @show_dessert.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    price_drink = @show_drink.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    @total = price_dish + price_dessert + price_drink
    @promotion = (@total.to_f * @promotion_discount.to_f)/100
  end

  def service_bill
  
    @table = Table.find(params[:id])
    @show_dish = MenuList.where(table: @table.id.to_s,menu_type: "อาหารคาว",billing_id: nil ,:kitchen.ne => nil, cancle: false)
    @show_dessert = MenuList.where(table: @table.id.to_s,menu_type: "อาหารหวาน",billing_id: nil,:kitchen.ne => nil, cancle: false)
    @show_drink = MenuList.where(table: @table.id.to_s,menu_type: "เครื่องดื่ม",billing_id: nil,:kitchen.ne => nil, cancle: false)
  
   

    price_dish = @show_dish.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    price_dessert = @show_dessert.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    price_drink = @show_drink.map { |i| i.menu_price.to_f * i.value.to_f}.compact.sum
    @total = price_dish + price_dessert + price_drink
    
  end
    

  def clear_table
    @table = Table.find(params[:id])
    @billing = Billing.where(restuarant_id: @table.restuarant_id)

    if @billing.length == 0
      @billing = Billing.new(billing_number: "1",time: Time.new,promotion_id: @table.promotion_id,restuarant_id: @table.restuarant_id,table_id: @table.id,user_id: current_user.id,date: Date.today.strftime("%Y-%m-%d"))
      @billing.save
    else
      @billing = Billing.new(billing_number: @billing.length.to_i+1,time: Time.new,promotion_id: @table.promotion_id,restuarant_id: @table.restuarant_id,table_id: @table.id,user_id: current_user.id,date: Date.today.strftime("%Y-%m-%d"))
      @billing.save
    end  

    @menu = MenuList.where(table: @table.id.to_s,billing_id: nil,:kitchen.ne => nil)
    @menu_clear = MenuList.where(table: @table.id.to_s,billing_id: nil)
    @menu.each do |list|
      list.update(billing_id: @billing.id ,restuarant_id: current_user.current_restuarant)
    end  
    @menu_clear.each do |list|
      list.destroy
    end  
    redirect_to menu_list_path(@table._id)

  end

  def create_params
    params.require(:menu_list).permit(:menu,:value,:remark,:menu_type,:table_id,:menu_price)
  end

end