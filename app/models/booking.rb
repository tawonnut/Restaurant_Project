class Booking
  include Mongoid::Document
  belongs_to :restuarant

  field :booking_name,    type: String
  field :booking_id,    type: String
  field :booking_time,    type: String
end


