class Billing
  include Mongoid::Document

  belongs_to :user
  belongs_to :table
  belongs_to :restuarant
  has_many :menu_lists
  belongs_to :promotion

  field :billing_number,        type: String
  field :time,                  type: Time
  field :date,					type: Date

end
