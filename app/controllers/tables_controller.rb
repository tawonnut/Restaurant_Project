class TablesController < ApplicationController

	def index
	end

	def new
	end

	def create
		@table = params[:table].to_i
		for i in 1..@table
	    @table = Table.new(table_number: "N/A",restuarant_id: current_user.current_restuarant)
	    @table.save
  	end
  	flash[:notice] = "สร้างโต๊ะเรียบร้อยเเล้ว"
	  redirect_to restuarant_path(current_user.current_restuarant)
  end

  def destroy
    @des= Table.find(params[:id])
    @des.destroy
    flash[:notice] = "ลบเรียบร้อยแล้ว"
    redirect_to restuarant_path(current_user.current_restuarant)
	end
	# def update	
	# 	if @user.update(user_params)
	# 		redirect_to timesheet_path, notice: 'อัพเดตเรียบร้อย'
	# 	else
	# 		flash[:error] = @user.errors.full_messages
	# 		render action: 'edit'
	# 	end
	# end



end
