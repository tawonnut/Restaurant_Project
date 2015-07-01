class Printer
  include Mongoid::Document

   belongs_to :restuarant

   field :model_name,    type: String
   field :api,    		 type: String

end
