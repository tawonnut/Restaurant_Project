class Membership
  include Mongoid::Document
  	belongs_to :user
  	
  field :owner,    type: Boolean

  #enum role: [:owner, :staff, :admin]

  #def set_default_role
	#self.role ||= :owner
  #end
end
