require "rails_helper"

feature "User signs in" do
  scenario "with valid email and password" do
    alice = Fabricate(:user)
    sign_in(alice)
    page.should have_content alice.full_name
  end
end