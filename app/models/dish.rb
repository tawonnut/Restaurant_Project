class Dish
  include Mongoid::Document
  belongs_to :restuarant

   field :dish_name,    type: String
   field :dish_price,   type: Float
   validates :dish_name,                  presence: {message: "กรุณาระบุชื่อเมนู"},uniqueness: {message: "ชื่อเมนูนี้มีอยู่ในระบบแล้ว"}
   validates :dish_price,             presence: {message: "กรุณาระบุราคา"},numericality: {message: "กรุณาระบุราคาเป็นตัวเลข"}

end
