class DrinkingsController < ApplicationController

	def new
		@drinking = Drinking.new
	end

  def show
    @restuarant= Restuarant.find(params[:id])
    @drinking = Drinking.where(restuarant_id: @restuarant.id)
  end

	def update
    @restuarant= Restuarant.find(params[:id])
    @drinking = Drinking.new(drinking_name: params[:drinking_name],drinking_price: params[:drinking_price],restuarant_id: @restuarant.id)
    if @drinking.save
      flash[:notice] = "เพิ่มเมนูเรียบร้อยแล้ว"
      redirect_to  drinking_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
      redirect_to add_drinking_restuarant_path
    end
  end

  def destroy
      @drinking= Drinking.find(params[:id])
      @restuarant= Restuarant.where(_id: @drinking.restuarant_id)
      @drinking.destroy
      flash[:notice] = "ลบเมนูเรียบร้อยแล้ว"
      redirect_to drinking_path(@restuarant[0].id)

  end

    end