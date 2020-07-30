module TimeSpentsHelper
  def time_spents_title
    if action_name == 'user_times'
      'User Group Times'
    elsif action_name == 'external_times'
      'External Times'
    elsif action_name == 'group_times'
      'Group Times'
    end
  end

  def author_name
    current_user.name if action_name == 'group_times'
  end

  def find_group(group_id)
    Group.find_by(id: group_id)
  end
end
