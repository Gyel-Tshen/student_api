class Activity < ApplicationRecord
    has_many :participations
    has_many :users, :through => :participations
end
