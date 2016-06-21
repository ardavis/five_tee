class Session < ActiveRecord::Base
  belongs_to :user

  def self.sort_options
    [
        {label: 'Alphabetical', sql: 'title ASC'},
        {label: 'Newest to Oldest', sql: 'created_at DESC'},
        {label: 'Oldest to Newest', sql: 'created_at ASC'},
        {label: 'Shortest Duration', sql: 'duration ASC'},
        {label: 'Longest Duration', sql: 'duration DESC'}
    ]
  end

  def sort_title
    {
        'title ASC' => 'Alphabetical',
        'created_at DESC' => 'Newest to Oldest',
        'created_at ASC' => 'Oldest to Newest',
        'duration ASC' => 'Shortest Duration',
        'duration DESC' => 'Longest Duration'
    }[self.sort_sql]
  end

  def filter_tag
    filter_tag_id ? Tag.find(filter_tag_id).name : 'All Tasks'
  end


end
