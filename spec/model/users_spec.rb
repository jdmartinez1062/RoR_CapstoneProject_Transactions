require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:user1) { User.create(name: 'test1') }
  let!(:user2) { User.create(name: 'test2') }
  describe 'create group' do
    it 'builds a group relation correctly' do
      user1.groups.create(name: 'dev1')
      group1 = user1.groups.first
      expect(user1).to eql(Group.find_by(selected_id: user1.id).selected)
      expect(user1.name).to eql(group1.selected.name)
    end
  end
  describe 'create transaction' do
    it 'builds the time spent relation correctly' do
      user1.groups.create(name: 'dev1')
      group1 = user1.groups.first
      user1.time_spents.create(name: 'art1', amount: 2, groups: group1)
      expect(user1).to eql(TimeSpent.find_by(author_id: user1.id).author)
    end
  end
end
