class Waiter
  include Mongoid::Document
  has_one :account

  field :waiter_id,        type: Integer
  field :waiter_name,      type: String
  field :waiter_surname,   type: String
  field :waiter_email,     type: String
  field :waiter_address,   type: String
  field :waiter_tel,       type: String
end
