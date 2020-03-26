class Rating < ActiveRecord::Base
    belongs_to :practice
    belongs_to :viewer
    
end