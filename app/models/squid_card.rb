class SquidCard < ActiveRecord::Base
  attr_accessible :uid, :reference

  validates :uid,       presence: true, uniqueness: true
  validates :reference, allow_blank: true, allow_nil: true, uniqueness: true
end
