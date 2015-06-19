class Promotion
  include Mongoid::Document

	belongs_to :restuarant
	has_one :table
	has_one :billing

  	field :promotion_id,    type: String
	field :promotion_name,    type: String
	field :promotion_discount, type: Integer 
end
