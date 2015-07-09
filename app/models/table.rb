class Table
  include Mongoid::Document

  	has_many :kitchens
  	has_many :billings
 	has_many :menu_lists
 	has_many :bookings
 	
    belongs_to :restuarant
    belongs_to :promotion
    



 field :table_number, type: Integer
 field :restuarant_id, type: String
 # field :table_status, type: Boolean
 # field :dessert, type: String
 # field :drinking, type: String
 # field :dish,	type: String
end
