class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_one :session, dependent: :destroy

  def incomplete_tasks
    tasks.incomplete
  end

  def completed_tasks
    tasks.completed
  end
end
