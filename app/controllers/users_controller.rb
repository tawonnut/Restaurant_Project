class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update]

  def edit
  end 


  def update
    if @user.update(user_params)
      redirect_to edit_users_path, notice: 'Update Success!!'
    else
      flash[:error] = "can't save ;("
      render action: 'edit'
    end
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name,:surname,:tel)
  end

  

end
