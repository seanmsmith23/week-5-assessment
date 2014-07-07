require "spec_helper"

feature "homepage" do
  scenario "a user that is not logged in should see the word 'Contacts'" do
    visit '/'

    expect(page).to have_content("Contacts")
  end
end