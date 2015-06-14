class Promotion
  include Mongoid::Document

	belongs_to :restuarant



  	field :promotion_id,    type: String
	field :promotion_name,    type: String
	field :promotion_discount, type: Integer 
end
