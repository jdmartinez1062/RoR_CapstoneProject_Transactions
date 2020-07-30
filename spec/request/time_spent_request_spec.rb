require './spec/helpers/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe UsersController, type: :request do
  let!(:user1) { User.create(name: 'test1', avatar: test_img_path) }
  let!(:group1) { user1.groups.create(name: 'Senior dev', icon: test_img_path) }
  let!(:transaction1) { group1.time_spents.create(name: 'Movement script', amount: 2, author_id: user1.id) }

  describe 'user attempts to create a time spent with out logging in ' do
    it 'fails' do
      expect do
        post new_time_spent_path(params: { time_spent: { name: 'Movement script', amount: 2, author_id: user1.id, group: group1.id } })
      end.to change(user1.time_spents, :count).by(0)
    end
  end

  describe 'user attempts to create a time spent when logged in ' do
    it 'succeeds' do
      post login_path(params: {session: {name: user1.name}})
      expect do
        post new_time_spent_path(params: { time_spent: { name: 'Movement script', amount: 2, author_id: user1.id, group: group1.id } })
      end.to change(user1.time_spents, :count).by(1)
    end
  end
end
