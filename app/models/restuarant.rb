class Restuarant
  include Mongoid::Document

   has_many :billings
   has_many :report
   has_many :memberships
   has_many :printers
   belongs_to :user
   belongs_to :waiter
   belongs_to :cashier
   has_many :drinkings
   has_many :desserts
   has_many :dishs
   has_many :tables
   has_many :promotions
   has_many :bookings
   has_many :kitchens
   belongs_to :menu_lists
   
   field :restuarant_name,    type: String
   field :user_id,            type: String
   field :restuarant_owner,   type: String
   field :printer_ip,         type: String
   field :printer_name,       type: String
   field :billing_id, 		   type: Integer
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

