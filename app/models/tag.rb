class Tag < ActiveRecord::Base
  has_many :tasks, dependent: :nullify
  belongs_to :user

  validates :name, presence: true, uniqueness: {scope: :user_id}, length: {minimum: 1, maximum: 20}

  def react_tag
    {
        'name' => name,
        'id' => id,
        'tasks' => tasks.count
    }
  end


end
