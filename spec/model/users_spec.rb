require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user1) { User.create(name: 'test1', avatar: test_img_path) }

  describe 'create group' do
    it 'builds a group relation correctly' do
      user1.groups.create(name: 'dev1', icon: test_img_path)
      group1 = user1.groups.first
      expect(user1).to eql(Group.find_by(selected_id: user1.id).selected)
      expect(user1.name).to eql(group1.selected.name)
    end
  end

  describe 'time spent relation' do
    it 'builds a time relation with a group' do
      user1.groups.create(name: 'dev1', icon: test_img_path)
      group.time_spents.create(name: 'C#', amount: 3, author_id: user1.id)
      expect(user1).to eql(TimeSpent.find_by(author_id: user1.id).author)
    end

    it 'builds a time relation with out a group' do
      user1.time_spents.create(name: 'C#', amount: 3)
      expect(user1).to eql(TimeSpent.find_by(author_id: user1.id).author)
    end
  end
end
