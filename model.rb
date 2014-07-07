def creates_session_id(user)
  @user_database.all.each do |user_hash|
    if user_hash[:username] == user
      session[:user_id] = user_hash[:id]
    end
  end
end

def find_users_name(session_id)
  user = @user_database.find(session_id)
  user[:username]
end

def contact_generator(user)
  contacts = @contact_database.find_for_user(user)

  output = contacts.map do |hash|
    '<li>' + hash[:name] + '</li>' + '<li>' + hash[:email] + '</li>'
  end
  output.join
end