class Dessert
  include Mongoid::Document

   belongs_to :restuarant

   field :dessert_name,    type: String
   field :dessert_price,   type: Integer
   validates :dessert_name, presence: true

end
