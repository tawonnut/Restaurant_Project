class ShowusersController < ApplicationController

	def index
	end

def showusers
	@users = User.all
end

end
