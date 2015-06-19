class Report
  include Mongoid::Document

    belongs_to :restuarant

 	field :report, type: Date

end
