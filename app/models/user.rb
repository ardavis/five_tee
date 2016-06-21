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
    incomplete_tasks = tasks.incomplete
    incomplete_tasks = incomplete_tasks.where(tag_id: session.filter_tag_id) if session.filter_tag_id
    incomplete_tasks.order(session.sort_sql)
  end

  def completed_tasks
    complete_tasks = tasks.completed
    complete_tasks = complete_tasks.where(tag_id: session.filter_tag_id) if session.filter_tag_id
    complete_tasks.order(session.sort_sql)
  end

  def tasks_hash
    {
        incomplete: incomplete_tasks.map{|task| task.react_task},
        complete: completed_tasks.map{|task| task.react_task}
    }
  end

  def tags_hash
    tags.map{|tag| tag.react_tag}
  end

  private

  def create_session
    self.session = Session.create user_id: self,
                                  filter_tag_id: nil,
                                  sort_sql: 'created_at DESC'
  end

end
