class Dessert
  include Mongoid::Document

   belongs_to :restuarant

   field :dessert_name,    type: String
   field :dessert_price,   type: Float
   validates :dessert_name, presence: true

end
