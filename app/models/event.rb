class Event < ApplicationRecord
    has_many :attendances
    has_many :users, through: :attendances
    has_many :event_tag_joins
    has_many :tags, through: :event_tag_joins
    belongs_to :admin, class_name: "User"
    validates :start_date, :duration, :title, :description, :price, :location, presence: true

    # manque la validation sur multiple de 5
    validate :start_date_cannot_be_in_the_past
    validate :is_multiple_of_5?
    validates :duration, numericality:{greater_than_or_equal_to: 0} 
    validates :title, length: {in: 5..140 }
    validates :description, length: {in: 20..1000 }
    validates :price, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1000 }

    def start_date_cannot_be_in_the_past
        if start_date.present? && start_date < Date.today
          errors.add(:start_date, "can't be in the past")
        end
    end

    def is_multiple_of_5?
        if duration.present? && duration % 5 != 0 && duration > 0
            errors.add(:duration, "has to be a multiple of 5")
        end
    end

    def end_date_calcul
        if duration.present? && start_date.present?
        	return end_date = start_date + duration
        end
    end

    def self.tagged_with(title)
        Tag.find_by!(title: title).posts
    end

    def self.tag_counts
        Tag.select('tags.*, count(event_tag_joins.tag_id) as count').joins(:event_tag_joins).group('event_tag_joins.tag_id')
    end

    def tag_list
        tags.map(&:title).join(', ')
      end
end
