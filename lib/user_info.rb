module UserInfo
  def current_user_id
    Thread.current[:user]
  end

  def self.current_user_id=(user)
    Thread.current[:user] = user
  end
end