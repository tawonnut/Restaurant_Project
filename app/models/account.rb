class Account
  include Mongoid::Document
   has_many :user
   belongs_to :waiter


   field :restuarant_name,    type: String
   field :restuarant_id,      type: Integer
   field :restuarant_owner,   type: String
   field :billing_id, 		  type: Integer
end
