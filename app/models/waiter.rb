class Waiter
  include Mongoid::Document

  belongs_to :restuarant

  field :waiter_id,        type: String
  field :waiter_name,      type: String
  field :waiter_surname,   type: String
  field :waiter_email,     type: String
  field :waiter_address,   type: String
  field :waiter_tel,       type: String
end
