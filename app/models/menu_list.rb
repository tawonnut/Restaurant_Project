class MenuList
  include Mongoid::Document

  belongs_to :table
  belongs_to :billing
  belongs_to :kitchen
  belongs_to :restuarant

  field :menu_type,    type: String
  field :menu,         type: String
  field :menu_price,   type: Float
  field :value,        type: Integer,default: 1
  field :remark,   	   type: String
  field :table_id,     type: String

  validates :menu,           presence: {message: "ที่อยู่: ยังไม่ได้กรอก กรุณากรอกใหม่"}

  def ng_json
    {
      id: self.id.to_s,
      menu_type: self.menu_type,
      menu_price: self.menu_price,
      menu: self.menu,
      table_id: self.table_id,
      value: self.value,
    }.as_json
  end

  def json_dish
    {
      id: self.id.to_s,
      dish_price: self.menu_price,
      dish_name: self.menu,
      value: self.value,
    }.as_json
  end

    def json_dessert
    {
      id: self.id.to_s,
      dessert_price: self.menu_price,
      dessert_name: self.menu,
      value: self.value,
    }.as_json
  end
  
    def json_drinking
    {
      id: self.id.to_s,
      drinking_price: self.menu_price,
      drinking_name: self.menu,
      value: self.value,
    }.as_json
  end

end
