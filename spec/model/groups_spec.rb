require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:user1) { User.create(name: 'test1') }
  let!(:user2) { User.create(name: 'test2') }
  describe 'create transaction' do
    it 'builds a transaction relation correctly' do
      user1.friendships.create(friend_id: user2.id)
      expect(user1.friendships.find_by(friend_id: user2.id)).to eql(user2.friend_requests.find_by(user_id: user1.id))
    end
  end
end
