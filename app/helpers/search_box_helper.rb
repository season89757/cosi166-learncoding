module SearchBoxHelper
  def find_displayname(user_id)

    user = User.find_by(id: user_id)
    if user.display_name
      return user.display_name
    else
      return "NoUserDisplayName"
    end
  end
end
