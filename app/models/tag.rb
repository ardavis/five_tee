class Tag < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  validates :name, presence: true, uniqueness: true


end
