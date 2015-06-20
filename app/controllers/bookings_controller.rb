class BookingsController < ApplicationController

	def new
		@booking = Booking.new
	end

  def show
    @restuarant_show = Restuarant.find(params[:id])
    @restuarant_user = Restuarant.where(user_id: current_user.id) 
    @restuarant= Restuarant.find(params[:id])
    @booking = Booking.where(restuarant_id: @restuarant.id)
    @bookings = Booking.new
  end

  def edit
    @booking= Booking.find(params[:id])
  end

	def update
    @restuarant= Restuarant.find(params[:id])
    @booking = Booking.new(booking_name: params[:booking_name],booking_time: params[:booking_time],restuarant_id: @restuarant.id)
    if @booking.save
      flash[:notice] = "เพิ่มรายการจองเรียบร้อยแล้ว"
      redirect_to  booking_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
    end
  end

  def update_promotion
      @booking = Booking.find(params[:id])
      @restuarant = Restuarant.where(_id: @promotion.restuarant_id)
    if @booking.update(booking_name: params[:booking][:booking_name],booking_time: params[:booking][:booking_time])
      flash[:notice] = "เปลี่ยนแปลงการจองเรียบร้อยแล้ว"
      redirect_to booking_path(@restuarant[0].id)
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
       redirect_to booking_path
    end
  end

  def destroy
      @booking = Booking.find(params[:id])
      @restuarant = Restuarant.where(_id: @promotion.restuarant_id)
      @booking.destroy
      flash[:notice] = "ลบโปรโมชันเรียบร้อยแล้ว"
      redirect_to booking_path(@restuarant[0].id)

  end
end
