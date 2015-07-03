class Promotion
  include Mongoid::Document

	belongs_to :restuarant
	has_one :table
	has_one :billing

  	field :promotion_id,    type: String   
	field :promotion_name,    type: String	
	field :promotion_discount, type: Float


	validates :promotion_name,              presence: {message: "กรุณาระบชื่อโปรโมชัน"}
	validates :promotion_discount,          presence: {message: "กรุณาระบุส่วนลด"},numericality: {message: "อัตราส่นลดระบุได้เฉพาะตัวเลข"}

end
