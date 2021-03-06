class User
  include Mongoid::Document

  has_many :billings
   has_many :restuarants
   has_many :memberships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  # Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  # Lockable
  field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  field :locked_at,       type: Time

  field :restuarant_id,  type: String 
  field :name,           type: String 
  field :surname,        type: String
  field :tel,            type: String,  default: 0000000000  
  field :current_restuarant,   type:BSON::ObjectId
  field :super_user,           type: Boolean, default: false
  field :tax_id,               type: Integer




   validates :name,                 presence: {message: "กรุณาระบุชื่อ"}  
   validates :surname,              presence: {message: "กรุณาระบุนามสกุล"}               
  


  
end
