class Dessert
  include Mongoid::Document

   belongs_to :restuarant

   field :dessert_name,    type: String
   field :dessert_price,   type: Float
 

  validates :dessert_name,              presence: {message: "กรุณาระบุชื่อเมนู"},uniqueness: {message: "ชื่อเมนูนี้มีอยู่ในระบบแล้ว"}
  validates :dessert_price,             presence: {message: "กรุณาระบุราคา"},numericality: {message: "กรุณาระบุราคาเป็นตัวเลข"}

end
