def log_in_with(name)
  visit login_path

  fill_in 'Name', with: name
  click_button 'Log in'
end

RSpec.feature 'Transactions', type: :feature do
  let!(:user1) { User.create(name: 'test1') }
  let!(:group1) do
    user1.groups.create(name: 'Senior dev',
                        icon: File.new(Rails.root + 'spec/fixtures/Sprite-0003.png', 'r'))
  end
  let!(:transaction1) { group1.time_spents.create(name: 'Movement script', amount: 2, author_id: user1.id) }

  scenario 'User creates a new transaction with group' do
    visit login_path
    log_in_with(user1.name)
    visit new_time_spent_path

    initial_count = TimeSpent.count

    fill_in 'Name', with: 'Movement script'
    fill_in 'Amount', with: 5
    expect(page).to have_select 'time_spent_groups', options: ['', group1.name]
    find('#time_spent_groups', text: group1.name).click
    click_button 'Submit time spent'

    final_count = TimeSpent.count

    expect(final_count - initial_count).to eq(1)
  end

  scenario 'User creates a new transaction without group' do
    visit login_path
    log_in_with(user1.name)
    visit new_time_spent_path
    initial_count = TimeSpent.count

    fill_in 'Name', with: 'Movement script'
    fill_in 'Amount', with: 5
    expect(page).to have_select 'time_spent_groups', options: ['', group1.name]
    find('#time_spent_groups', text: '').click
    click_button 'Submit time spent'

    final_count = TimeSpent.count

    expect(final_count - initial_count).to eq(1)
  end

  scenario 'User visits my group transactions page' do
    visit login_path
    log_in_with(user1.name)
    visit user_path(user1)
    click_link('My work times')

    transactions_i = user1.group_time_spents.paginate(page: 1)
    transactions_i.each do |transaction|
      expect(page).to have_css('p', text: transaction.time_name.to_s)
      expect(page).to have_css('p', text: transaction.time_amount.to_s)
      expect(page).to have_css('p', text: transaction.time_log.to_s)
      expect(page).to have_css("img[src*= '#{transaction.icon.url}']")
    end
  end
  scenario 'User visits external transactions page' do
    visit login_path
    log_in_with(user1.name)
    visit user_path(user1)
    click_link('My external times')

    transactions_i = user1.external_time_spents.paginate(page: 1)
    transactions_i.each do |transaction|
      expect(page).to have_css('p', text: transaction.time_name.to_s)
      expect(page).to have_css('p', text: transaction.time_amount.to_s)
      expect(page).to have_css('p', text: transaction.time_log.to_s)
    end
  end
  scenario 'User visits the group transactions page' do
    visit login_path
    log_in_with(user1.name)
    visit group_times_path(group1)

    transactions_i = group1.group_spents.paginate(page: 1)
    transactions_i.each do |transaction|
      expect(page).to have_css('p', text: user1.name)
      expect(page).to have_css('p', text: transaction.time_name.to_s)
      expect(page).to have_css('p', text: transaction.time_amount.to_s)
      expect(page).to have_css('p', text: transaction.time_log.to_s)
    end
  end
end
