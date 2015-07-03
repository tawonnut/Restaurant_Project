class Restuarant
  include Mongoid::Document

   has_many :billings
   has_many :report
   has_many :memberships
   has_many :printers
   belongs_to :user
   belongs_to :waiter
   belongs_to :cashier
   has_many :drinkings
   has_many :desserts
   has_many :dishs
   has_many :tables
   has_many :promotions
   has_many :bookings
   has_many :kitchens
   has_many :menu_lists
   
   field :restuarant_name,    type: String      
   field :user_id,            type: String
   field :restuarant_owner,   type: String
   field :printer_ip,         type: String
   field :printer_name,       type: String
   field :billing_id, 		   type: Integer
   field :restuarant_address, type: String      
   field :restuarant_tel,     type: String     
   field :restuarant_email,   type: String     
   field :legal_person,       type: String            
   field :tax_id,             type: String   


     validates :restuarant_name,                  presence: {message: "กรุณาระบุชื่อร้าน"},uniqueness: {message: "ชื่อร้านนี้ มีอยู่ในระบบแล้ว"}
     validates :restuarant_address,               presence: {message: "กรุณาระบุที่อยู่ร้าน"}
     validates :restuarant_tel,                   presence: {message: "กรุณาระบุเบอร์โทรศัพท์ของร้าน"}, numericality: {message: "เบอร์โทรศัพท์กรอกได้เฉพาะตัวเลข"}                   
     validates :legal_person,                     presence: {message: "กรุณาระบุชื่อนิติบุคคล"}    
     validates :tax_id,                           presence: {message: "กรุณาระบุเลขที่เสียภาษี"}, numericality: {message: "เลขที่เสียภาษีกรอกได้เฉพาะตัวเลข"}                    
   

               
 




def create_owner(user,restuarant)
   @owner = Membership.new(user_id: user, restuarant_id: restuarant,owner: true)
   @owner.save
end


def create_staff(user,restuarant)
   @owner = Membership.new(user_id: user, restuarant_id: restuarant)
   @owner.save
end




end

