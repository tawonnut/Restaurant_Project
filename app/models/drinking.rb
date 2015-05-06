class Drinking
  include Mongoid::Document
  belongs_to :restuarant

   field :drinking_name,    type: String
   field :drinking_price,   type: String
   validates :drinking_name, presence: true

end
