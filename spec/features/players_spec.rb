require 'rails_helper'

RSpec.feature "Players", type: :feature do
  background do
    Player.new(:email => 'player.stub1@test.com', :password => 'asdasdasd')
  end

  scenario "Signing in with correct credentials" do
    visit '/en/players/sign_in'
    # within("#new_player") do
    #   fill_in 'player_email', :with => 'player.stub1@test.com'
    #   fill_in 'player_password', :with => 'asdasdasd'
    # end
    find("#player_email").set "player.stub1@test.com"
    find("#player_password").set "asdasdasd"
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end

  given(:other_user) { Player.new(:email => 'other@example.com', :password => 'fail') }

  scenario "Signing in as another user" do
    visit '/en/players/sign_in'
    within("#new_player") do
      fill_in 'player_email', :with => other_user.email
      fill_in 'player_password', :with => other_user.password
    end
    click_button 'Sign in'
    expect(page).to have_content 'Invalid email or password'
  end
end
