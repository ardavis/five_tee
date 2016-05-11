module TagsHelper

  def tags_hash
    current_user.tags.to_a.map{|tag| react_tag(tag)}
  end

  def react_tag(tag)
    {
        'name' => tag.name,
        'id' => tag.id,
        'tasks' => tag.tasks.count
    }
  end

end
