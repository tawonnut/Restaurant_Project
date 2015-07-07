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

  def self.to_csv()
  	attributes = %w{billing_number วันที่ พนักงาน ชื่ออาหาร จำนวน ราคา/บาท เป็นเงิน}

  	CSV.generate(headers: true) do |csv|
  	csv << attributes

  	all.each do |report|
  		# csv << attributes.{ |attr| report.send(attr) }
  		csv << [report.billing_number, report.date, report.user.name]
  	end

  end
end

end
 	