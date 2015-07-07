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
  field :cancle,       type: Boolean, default: false

  validates :menu,           presence: {message: "กรุณาเลือกเมนู"}


  def self.to_csv()
    attributes = %w{billing_number วันที่ พนักงาน ชื่ออาหาร จำนวน ราคา/บาท เป็นเงิน(บาท)}

    CSV.generate(headers: true) do |csv|
    csv << attributes

    all.each do |report|
      # csv << attributes.{ |attr| report.send(attr) }
      csv << [report.billing.billing_number,report.billing.date, report.billing.user.name, report.menu, report.value, report.menu_price, report.menu_price.to_f * report.value.to_f]
    end
  end
end


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
