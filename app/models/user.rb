class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :kerberos

  after_create :create_session

  has_many :tasks, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_one :session, dependent: :destroy
  has_many :archives, dependent: :destroy

  def incomplete_tasks
    tasks.incomplete
  end

  def completed_tasks
    tasks.completed
  end

  private

  def create_session
    self.session = Session.create user_id: self,
                                  filter_tag_id: nil,
                                  sort_sql: 'created_at DESC'
  end

end
