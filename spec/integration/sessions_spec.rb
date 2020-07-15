RSpec.feature 'Login', type: :feature do
  let!(:user1) { User.create(name: 'test1') }

  scenario 'User visits the Log in page and logs in with correct information' do
    visit login_path

    fill_in 'Name', with: 'test1'
    click_button 'Log in'
    current_user = User.find_by(name: 'test1')
    expect(page).to have_current_path(user_path(current_user))
    expect(page).to have_css('p', text: current_user.name.to_s)
    expect(page).to have_css('a', text: 'Log out')
  end
  scenario 'User visits the signup page and does not logs in with incorrect correct information' do
    visit login_path

    fill_in 'Name', with: ''
    click_button 'Log in'
    expect(page).to have_current_path(login_path)
    expect(page).to have_css('div', text: 'Log in unsuccessful')
  end
end
