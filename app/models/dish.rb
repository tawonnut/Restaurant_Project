class Dish
  include Mongoid::Document
  belongs_to :restuarant



   field :dish_name,    type: String
   field :dish_price,   type: String


   validates :dish_name, presence: true

end
