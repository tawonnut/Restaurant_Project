class Drinking
  include Mongoid::Document
  belongs_to :restuarant

   field :drinking_name,    type: String
   field :drinking_price,   type: Integer
   validates :drinking_name, presence: true
   validates :drinking_price, presence: true
   
end
