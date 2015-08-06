class BookingsController < ApplicationController

	def new
		@booking = Booking.new
	end

  def show
    @restuarant_show = Restuarant.where(id: current_user.current_restuarant).first
    @restuarant_user = Restuarant.where(user_id: current_user.id) 
    @restuarant= Restuarant.where(id: current_user.current_restuarant).first
    @booking = Booking.where(restuarant_id: @restuarant.id).order(booking_date: "aesc", booking_time: "aesc")
    @bookings = Booking.new
  end

  def update
        @restuarant= Restuarant.where(id: current_user.current_restuarant).first
        @booking = Booking.new(booking_name: params[:booking_name],booking_time: params[:booking_time],booking_person: params[:booking_person],booking_tel: params[:booking_tel],booking_date: params[:booking_date],restuarant_id: @restuarant.id)
    if @booking.save
      flash[:notice] = "เพิ่มรายการจองเรียบร้อยแล้ว"
      redirect_to  booking_path
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
    end
  end

  def edit
    @booking= Booking.find(params[:id])
  end

  def update_booking
      @booking = Booking.find(params[:id])
      @restuarant = Restuarant.where(_id: @booking.restuarant_id)
    if @booking.update(booking_name: params[:booking_name],booking_time: params[:booking_time],booking_person: params[:booking_person],booking_tel: params[:booking_tel],booking_date: params[:booking_date])
      flash[:notice] = "เปลี่ยนแปลงการจองเรียบร้อยแล้ว"
      redirect_to booking_path(@restuarant[0].id)
    else
      flash[:error] = "กรุณาระบุข้อมูลให้ครบถ้วน"
       redirect_to booking_path
    end
  end

  def destroy
      @booking = Booking.find(params[:id])
      @restuarant = Restuarant.where(_id: @booking.restuarant_id)
      @booking.destroy
      flash[:notice] = "ลบข้อมูลการจองเรียบร้อยแล้ว"
      redirect_to booking_path(@restuarant[0].id)

  end
end
