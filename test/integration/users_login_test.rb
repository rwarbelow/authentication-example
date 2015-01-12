require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  test "cannot login with invalid credentials" do
    visit login_path
    fill_in "session[username]", with: ""
    fill_in "session[password]", with: ""
    click_link_or_button "Login"
    within("#errors") do
      assert page.has_content?("Invalid")
    end
  end

  test "registered user can login" do
    user = User.create(username: "example", password: "password")
    visit login_path
    fill_in "session[username]", with: "example"
    fill_in "session[password]", with: "password"
    click_link_or_button "Login"
    within("#banner") do
      assert page.has_content?("Welcome, example")
    end
  end
end
