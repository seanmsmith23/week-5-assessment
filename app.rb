require "sinatra"
require "./lib/database"
require "./lib/contact_database"
require "./lib/user_database"
require_relative "model"

class ContactsApp < Sinatra::Base
  enable :sessions

  def initialize
    super
    @contact_database = ContactDatabase.new
    @user_database = UserDatabase.new

    jeff = @user_database.insert(username: "Jeff", password: "jeff123")
    hunter = @user_database.insert(username: "Hunter", password: "puglyfe")

    @contact_database.insert(:name => "Spencer", :email => "spen@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Jeff D.", :email => "jd@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Mike", :email => "mike@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Kirsten", :email => "kirsten@example.com", user_id: hunter[:id])
  end

  get "/" do

    if session[:user_id]
      erb :loggedin, :locals => { :name => find_users_name(session[:user_id]), :contact_info => contact_generator(session[:user_id]) }
    else
      erb :homepage
    end
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    user = params[:username]
    creates_session_id(user)
    redirect '/'
  end

  post "/signout" do
    session.delete(:user_id)
    redirect '/'
  end

end
