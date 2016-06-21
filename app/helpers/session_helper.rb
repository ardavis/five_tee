module SessionHelper

  def sort_options
    [
        {label: 'Alphabetical', sql: 'title ASC'},
        {label: 'Newest to Oldest', sql: 'created_at DESC'},
        {label: 'Oldest to Newest', sql: 'created_at ASC'},
        {label: 'Shortest Duration', sql: 'duration ASC'},
        {label: 'Longest Duration', sql: 'duration DESC'}
    ]
  end

end
