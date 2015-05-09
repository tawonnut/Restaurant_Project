class Restuarant
  include Mongoid::Document

   has_many :memberships
   belongs_to :user
   belongs_to :waiter
   belongs_to :cashier
   has_many :drinkings
   has_many :desserts
   has_many :dishs

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

def create_owner(user,restuarant)
   @owner = Membership.new(user_id: user, restuarant_id: restuarant,owner: true)
   @owner.save
end


def create_staff(user,restuarant)
   @owner = Membership.new(user_id: user, restuarant_id: restuarant)
   @owner.save
end




end

