def log_in_with(name)
  visit login_path

  fill_in 'Name', with: name
  click_button 'Log in'
end
RSpec.feature 'New Group', type: :feature do
  let!(:user1) { User.create(name: 'test1') }

  scenario 'User creates a group with correct information' do
    log_in_with(user1.name)
    visit new_group_path

    fill_in 'Name', with: 'dev1'
    attach_file('group_icon', Rails.root + 'spec/fixtures/img1.jpg')
    click_button 'Create new group'
    group = Group.find_by(name: 'dev1')
    expect(page).to have_current_path(group_path(group))
  end
  scenario 'User creates a group with incorrect correct information' do
    visit new_group_path

    fill_in 'Name', with: ''
    click_button 'Create new group'
    expect(page).to have_current_path(new_group_path)
    expect(page).to have_css('div', text: "New group couldn't be created")
  end
end
