class Table
  include Mongoid::Document

 	has_many :menu_lists
    belongs_to :restuarant

 field :table_number, type: Integer
 field :restuarant_id, type: String
 # field :table_status, type: Boolean
 # field :dessert, type: String
 # field :drinking, type: String
 # field :dish,	type: String
end