class WelcomesController < ApplicationController

before_action :authenticate_user!, only: [:edit, :update, :new, :create,:destroy]	
  def index
  end

  def welcomes
	end
end
