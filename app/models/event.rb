class Event < ApplicationRecord
    has_and_belongs_to_many :users

    validates :start_date, :duration, :title, :description, :price, :location, presence: true

    # manque la validation sur multiple de 5
    validates :duration, numericality:{greater_than_or_equal_to: 0} 
    validates :title, length: { minimum: 5 }, length: {maximum: 140}
    validates :description, length: { minimum: 20 }, length: {maximum: 1000}
    validates :price, numericality: { less_than:1000 }, numericality: { more_than:1 }

end
