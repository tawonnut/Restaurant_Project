class Cashier
  include Mongoid::Document
   has_one :account
  field :cashier_id,        type: Integer
  field :cashier_name,      type: String
  field :cashier_surname,   type: String
  field :cashier_email,     type: String
  field :cashier_address,   type: String
  field :cashier_tel,       type: String
end
