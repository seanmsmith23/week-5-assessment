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

feature "login" do
  scenario "user should be able to login and then no longer see the login form. they should also see their name" do
    visit '/login'

    fill_in "username", :with => "Spencer"
    fill_in "password", :with => "pen@example.com"
    click_button "Submit"

    expect(page).to have_content "Welcome, Spencer"
    expect(page).to_not have_link "Login"
  end
end
end