class Viewer < ActiveRecord::Base
    has_many :ratings
    has_many :practices, through: :ratings



# Get the top rated show for this viewer
def favorite_practice
    ratings.order(rating: :DESC).limit(1).collect(&:practice)
end

# Get top three rated practices for this viewer
def top_three
    ratings.order(rating: :DESC).limit(3)
  end
end

