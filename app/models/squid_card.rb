class SquidCard < ActiveRecord::Base
  attr_accessible :uid, :reference

  validates :uid,       presence: true, uniqueness: true
  validates :reference, presence: true, nil: true, uniqueness: true
end
