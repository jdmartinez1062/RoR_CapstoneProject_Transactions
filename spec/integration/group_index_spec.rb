def log_in_with(name)
  visit login_path

  fill_in 'Name', with: name
  click_button 'Log in'
end
RSpec.feature 'Group Index', type: :feature do
  let!(:user1) { User.create(name: 'test1') }

  scenario 'Shows all the created groups' do
    log_in_with(user1.name)
    visit groups_path
    groups_i = Group.paginate(page: 1)
    expect(page).to have_css('a', text: 'Create new', count: 1)
    groups_i.each do |group|
      expect(page).to have_css('p', text: "Name: #{group.name}")
      expect(page).to have_css("img[src*=#{group.icon}]")
    end
  end
end