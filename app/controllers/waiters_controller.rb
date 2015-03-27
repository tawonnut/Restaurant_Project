class WaitersController < ApplicationController

  def index
    @waiters = Waiter.all
  end

  def show
    
  end

  def new
    @waiter = Waiter.new
  end

  def edit
  end

  def create
    @waiter = Waiter.new(waiter_params)

    respond_to do |format|
      if @waiter.save
        format.html { redirect_to @waiter, notice: 'Waiter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @waiter }
      else
        format.html { render action: 'new' }
        format.json { render json: @waiter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @waiter.update(waiter_params)
        format.html { redirect_to @waiter, notice: 'student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @waiter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @waiter.destroy
    respond_to do |format|
      format.html { redirect_to waiters_path, notice: 'Delete student successfully .' }
      format.json { head :no_content }
    end
  end

  private

  def set_waiter
    @student = Waiter.find(params[:id])
  end

  def waiter_params
    params.require(:waiter).permit(:waiter_id, :waiter_name)
  end

end
