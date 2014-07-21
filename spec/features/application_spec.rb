require 'spec_helper'

feature 'Homepage' do
  scenario 'Shows the welcome message' do
    visit '/'

    expect(page).to have_content 'Welcome!'
  end
end

feature 'Messages' do
  scenario "When a user enters their name and message, they see it listed below" do
    visit '/'
    fill_in('name', :with => 'user')
    fill_in('message', :with => 'blah')
    click_button 'Add message'
    expect(page).to have_content('user')
    expect(page).to have_content('blah')
  end
end

feature 'Continents' do
  scenario "When a user visits the continent page, they can click the continents and see the correct country" do
    visit '/'
    click_on 'Continents'
    click_on 'Africa'
    expect(page).to have_content("Kenya")
    expect(page).to have_content("South Africa")
    expect(page).to_not have_content("United States")
  end
end