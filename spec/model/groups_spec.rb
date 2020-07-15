require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:user1) { User.create(name: 'test1') }

  describe 'create transaction' do
    it 'builds the time spent relation correctly' do
      user1.groups.create(name: 'dev1')
      group1 = user1.groups.first
      group1.time_spents.create(name: 'art1', amount: 2, author_id: user1.id)
      expect(user1).to eql(TimeSpent.find_by(author_id: user1.id).author)
    end
  end
end
