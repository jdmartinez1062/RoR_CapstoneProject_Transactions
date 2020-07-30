require './spec/helpers/helpers'

RSpec.configure do |c|
  c.include Helpers
end
RSpec.feature 'Loged in security', type: :feature do
  let!(:user1) { User.create(name: 'test1', avatar: test_img_path) }

  scenario 'user cant see new group page with out loggin in' do
    visit new_group_path

    expect(page).to have_css('div', text: 'Please log in.')
    expect(page).to have_current_path(login_path)
  end

  scenario 'user cant see transaciton page with out loggin in' do
    visit new_time_spent_path
    expect(page).to have_css('div', text: 'Please log in.')
    expect(page).to have_current_path(login_path)
  end

  scenario 'user cant see his or another profile page with out loggin in' do
    visit user_path(user1)
    expect(page).to have_css('div', text: 'Please log in.')
    expect(page).to have_current_path(login_path)
  end
end
