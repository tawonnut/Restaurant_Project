class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update]


def new
    unless current_user.super_user?
      flash[:error] = "You don't have permisson to access the requested page."
      redirect_to restuarant_path(current_user)
    else
       @user = User.new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_users_path, notice: 'แก้ไขเรียบร้อยแล้ว!!'
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

