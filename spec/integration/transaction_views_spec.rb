require './spec/helpers/helpers'

RSpec.configure do |c|
  c.include Helpers
end
RSpec.feature 'Transactions', type: :feature do
  let!(:user1) { User.create(name: 'test1') }
  let!(:group1) { user1.groups.create(name: 'Senior dev', icon: test_img_path) }
  let!(:transaction1) { group1.time_spents.create(name: 'Movement script', amount: 2, author_id: user1.id) }
  before(:each) { standard_procedure }

  scenario 'User visits my group transactions page' do
    visit user_path(user1)
    click_link('My work times')

    transactions_i = user1.group_time_spents.paginate(page: 1)
    transactions_i.each do |transaction|
      expect_standard(transaction)
      expect(page).to have_css("img[src*= '#{transaction.icon.url}']")
    end
  end
  scenario 'User visits external transactions page' do
    visit user_path(user1)
    click_link('My external times')

    transactions_i = user1.external_time_spents.paginate(page: 1)
    transactions_i.each do |transaction|
      expect_standard(transaction)
    end
  end
  scenario 'User visits the group transactions page' do
    visit group_times_path(group1)

    transactions_i = group1.group_spents.paginate(page: 1)
    transactions_i.each do |transaction|
      expect(page).to have_css('p', text: user1.name)
      expect_standard(transaction)
    end
  end
end
