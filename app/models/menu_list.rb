class MenuList
  include Mongoid::Document

  belongs_to :table

  field :menu_type,    type: String
  field :menu,         type: String
  field :value,        type: Integer
  field :remark,   	   type: String


end
