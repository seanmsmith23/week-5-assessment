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