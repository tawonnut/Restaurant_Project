class Kitchen
  include Mongoid::Document

    belongs_to :restuarant
    belongs_to :table
    has_many :menu_lists

end
