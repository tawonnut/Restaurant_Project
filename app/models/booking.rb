class Booking
  include Mongoid::Document
  belongs_to :restuarant

  field :booking_name,    type: String
  field :booking_id,    type: String
  field :booking_time,    type: String


   validates :booking_name,              presence: {message: "กรุณาระบุชื่อลูกค้าที่จอง"}
   validates :drinking_time,             presence: {message: "กรุณาระบุเวลาที่จอง"}



end


