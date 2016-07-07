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

  def archives_hash
    archives = []
    self.archives.order('created_at DESC').each do |a|
      archive = {
          created_at: a.created_at,
          created_at_display: a.created_at.in_time_zone('America/New_York').strftime('%m-%d-%Y %I:%M %P'),
          id: a.id,
          tasks: a.archive_tasks_hash
      }
      archives.push(archive)
    end
    archives
  end


  def filtered_tasks
    if self.session.filter_tag_id and self.session.filter_tag_id != 0
      self.tasks.where(tag_id: self.session.filter_tag_id)
    else
      self.tasks
    end
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
