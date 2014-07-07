require "spec_helper"

feature "homepage" do
  scenario "a user that is not logged in should see the word 'Contacts'" do
    visit '/'

    expect(page).to have_content("Contacts")
  end

  scenario "a user that is not logged in should see a link to be taken to the login page" do
    visit '/'

    expect(page).to have_link("Login")

    click_link ("Login")

    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
    expect(page).to have_button("Submit")
  end
end

feature "login" do
  scenario "user should be able to login and then no longer see the login form. they should also see their name" do
    visit '/login'

    fill_in "username", :with => "Jeff"
    fill_in "password", :with => "pen@example.com"
    click_button "Submit"

    expect(page).to have_content "Welcome, Jeff"
    expect(page).to_not have_link "Login"
  end
end

feature "view contacts" do
  scenario "user should visit the home page and see a list of their contacts" do
    visit '/login'

    fill_in "username", :with => "Jeff"
    fill_in "password", :with => "jeff123"
    click_button "Submit"

    expect(page).to have_content "Spencer"
    expect(page).to have_content "spen@example.com"
    expect(page).to have_content "Jeff D."
    expect(page).to have_content "jd@example.com"
    expect(page).to have_content "Mike"
    expect(page).to have_content "mike@example.com"
  end
end

feature "logout" do
  scenario "user should logout and not see welcome" do
    visit '/login'

    fill_in "username", :with => "Jeff"
    fill_in "password", :with => "jeff123"
    click_button "Submit"

    click_button "Logout"

    expect(page).to have_link("Login")
  end
end
