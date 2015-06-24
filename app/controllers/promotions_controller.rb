class PromotionsController < ApplicationController

def new
		@promotion = Promotion.new
	end

  def show
    @restuarant_show = Restuarant.where(id: current_user.current_restuarant).first
    @restuarant_user = Restuarant.where(user_id: current_user.id) 
    @restuarant= Restuarant.where(id: current_user.current_restuarant).first
    @promotion = Promotion.where(restuarant_id: @restuarant.id)
    @promotions = Promotion.new
  end

  def edit
    @promotion= Promotion.find(params[:id])
  end

	def update
    @restuarant= Restuarant.where(id: current_user.current_restuarant).first
    @promotion = Promotion.new(promotion_name: params[:promotion_name],promotion_discount: params[:promotion_discount],restuarant_id: @restuarant.id)
    if @promotion.save
      flash[:notice] = "เพิ่มโปรโมชั่นเรียบร้อยแล้ว"
      redirect_to  promotion_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
    end
  end

  def update_promotion
      @promotion = Promotion.find(params[:id])
      @restuarant = Restuarant.where(_id: @promotion.restuarant_id)
    if @promotion.update(promotion_name: params[:promotion][:promotion_name],promotion_discount: params[:promotion][:promotion_discount])
      flash[:notice] = "แก้ไขโปรโมชั่นเรียบร้อยแล้ว"
      redirect_to promotion_path(@restuarant[0].id)
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
       redirect_to promotion_path
    end
  end

  def destroy
      @promotion= Promotion.find(params[:id])
      @restuarant= Restuarant.where(_id: @promotion.restuarant_id)
      @promotion.destroy
      flash[:notice] = "ลบโปรโมชันเรียบร้อยแล้ว"
      redirect_to promotion_path(@restuarant[0].id)

  end

end
