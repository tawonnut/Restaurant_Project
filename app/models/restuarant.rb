class Restuarant
  include Mongoid::Document

   belongs_to :user
   belongs_to :waiter
   belongs_to :cashier

   field :restuarant_name,    type: String
   field :user_id,      type: String
   field :restuarant_owner,   type: String
   field :billing_id, 		  type: Integer
   field :restuarant_address, type: String
   field :restuarant_tel,    type: String
   field :restuarant_email,    type: String
   field :legal_person,type: String
   field :tax_id, type: String


   validates :restuarant_name, presence: true
end

