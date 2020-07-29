require './spec/helpers/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.feature 'Transactions', type: :feature do
  let!(:user1) { User.create(name: 'test1') }
  let!(:group1) do
    user1.groups.create(name: 'Senior dev',
                        icon: File.new(Rails.root + 'spec/fixtures/Sprite-0003.png', 'r'))
  end
  let!(:transaction1) { group1.time_spents.create(name: 'Movement script', amount: 2, author_id: user1.id) }

  scenario 'User creates a new transaction with group' do
    standard_procedure
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
    standard_procedure
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
end
