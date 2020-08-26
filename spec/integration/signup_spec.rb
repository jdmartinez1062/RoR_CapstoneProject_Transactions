RSpec.feature 'Signup', type: :feature do
  scenario 'User visits the signup page and signs up with correct information' do
    visit signup_path

    fill_in 'user_name', with: 'test1'
    attach_file('user_avatar', Rails.root + 'spec/fixtures/img1.jpg')
    click_button 'Sign up'

    current_user = User.find_by(name: 'test1')
    expect(page).to have_current_path(user_path(current_user))
    expect(page).to have_css('p', text: current_user.name.to_s)
    expect(page).to have_css('a', text: 'Log out')
  end
  scenario 'User visits the signup page and does not signs up with incorrect correct information' do
    visit signup_path

    fill_in 'user_name', with: ''
    click_button 'Sign up'
    expect(page).to have_current_path(signup_path)
    expect(page).to have_css('div', text: 'There was a problem')
  end
end
