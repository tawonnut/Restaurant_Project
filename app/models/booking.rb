class Booking
  include Mongoid::Document


  belongs_to :restuarant
  belongs_to :table

  field :booking_name,    type: String
  field :booking_id,      type: String
  field :booking_time,    type: Time
  field :booking_date,    type: Date
  field :booking_person,  type: Integer
  field :booking_tel,     type: String


   validates :booking_name,             presence: {message: "กรุณาระบุชื่อลูกค้าที่จอง"}
   validates :booking_time,             presence: {message: "กรุณาระบุเวลาที่จอง"}
   validates :booking_person,           presence: {message: "กรุณาระบุจำนวนคน"}
   validates :booking_tel,              numericality: {message: "เบอร์โทรระบุได้เฉพาะตัวเลข"}    



end


