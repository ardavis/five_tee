class Session < ActiveRecord::Base
  belongs_to :user

  def sort_title
    [
        {label: 'Alphabetical', sql: 'title ASC'},
        {label: 'Newest to Oldest', sql: 'created_at DESC'},
        {label: 'Oldest to Newest', sql: 'created_at ASC'},
        {label: 'Shortest Duration', sql: 'duration ASC'},
        {label: 'Longest Duration', sql: 'duration DESC'}
    ].each do |sort_option|
      return sort_option.keys.first if sort_option.values.first == self.sort_sql
    end
  end


end
