class Membership
  include Mongoid::Document
  	belongs_to :user
  	belongs_to :restuarant
  	
  field :owner,    type: Boolean, default: false
  
end
