class Membership
  include Mongoid::Document
  	belongs_to :user
  	
  field :owner,    type: Boolean, default: false
  
end
