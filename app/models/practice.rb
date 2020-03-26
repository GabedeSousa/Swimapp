class Practice < ActiveRecord::Base
    has_many :ratings
    has_many :viewers, through: :ratings
  
# Number of ratings for this practice
def num_ratings
    ratings.count
end
# media de rating para este treino de viewers
def average_rating
    (ratings.sum(:rating).to_f / num_ratings).round(1)
end

# retorna o treino com a maior media de rating
def self.highest_average_rating
    Practice.all.max_by do |practice| 
        practice.average_rating 
    end
end

  # retorna o treino com o numero mais alto de viewers
  def self.most_viewers
    Practice.all.max_by do |practice| 
        practice.viewers.count 
    end
end

  # retorna um array unico de treinos no pais
  def self.countries
    Practice.select(:country).distinct.collect(&:country)
end
end