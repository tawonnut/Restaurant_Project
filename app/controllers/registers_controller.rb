class RegistersController < ApplicationController

	def new
       @user = User.new
	end

	def index
		@users = User.all
	end

	def edit
	end

	def create
    @user = User.new(create_user_params)
    random_password = Devise.friendly_token

    id = params[:user][:restuarant_id]

    @user.password = random_password
    @user.password_confirmation = random_password
    # @user.name = "N/A"
    # @user.surname = "N/A"
    # @user.tel = "N/A"
    # @user.restuarant_id = id
    


    if @user.save(user_params)
      @user.send_reset_password_instructions
      flash[:notice] = "Create new user successfully."
      redirect_to registers_path(current_user)
    else
      flash.now[:error] ||= []
      flash[:error] << @user.errors.full_messages.uniq.join(', ')
      render action: :new
    end
  end

	def update
		if @user.update(user_params)
			redirect_to timesheet_path, notice: 'User was successfully updated.'
		else
			flash[:error] = @user.errors.full_messages
			render action: 'edit'
		end
	end

	private


	def create_user_params
    params.require(:user).permit(:email)
  end

	def user_params
		params.require(:user).permit(:name, :surname, :nickname, :tel, :restuarant_id)
	end

end
