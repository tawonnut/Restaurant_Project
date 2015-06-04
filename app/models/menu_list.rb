class MenuList
  include Mongoid::Document

  belongs_to :table

  field :menu_type,    type: String
  field :menu,         type: String
  field :value,        type: Integer,default: 1
  field :remark,   	   type: String
  field :table_id,        type: String
  validates :menu,           presence: {message: "ที่อยู่: ยังไม่ได้กรอก กรุณากรอกใหม่"}

  
  def ng_json
    {
      id: self.id.to_s,
      menu_type: self.menu_type,
      menu: self.menu,
      table_id: self.table_id,
      value: self.value,
    }.as_json
  end
end
