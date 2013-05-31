class Event < ActiveRecord::Base
  attr_accessible :key, :card_uid, :resource, :name

  validates :key, presence: true, uniqueness: true
end
