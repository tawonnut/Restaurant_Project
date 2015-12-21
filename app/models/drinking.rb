class Drinking
  include Mongoid::Document
  belongs_to :restuarant

   field :drinking_name,    type: String
   field :drinking_price,   type: Float
   validates :drinking_name,              presence: {message: "กรุณาระบุชื่อเมนู"},uniqueness: {message: "ชื่อเมนูนี้มีอยู่ในระบบแล้ว"}
   validates :drinking_price,             presence: {message: "กรุณาระบุราคา"},numericality: {message: "กรุณาระบุราคาเป็นตัวเลข"}

end
