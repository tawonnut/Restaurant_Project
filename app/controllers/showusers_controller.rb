class ShowusersController < ApplicationController

	def index
	end

	def showusers
		@users = User.all
	end

 	def destroy
    	@user= User.find(params[:id])
    	@user.destroy
    	flash[:notice] = "ลบเรียบร้อยแล้ว"
    	redirect_to showusers_showusers_path
	end

  
end
