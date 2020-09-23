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
      group1 = user1.groups.first
      group1.time_spents.create(name: 'C#', amount: 3, author_id: user1.id)
      expect(user1).to eql(TimeSpent.find_by(author_id: user1.id).author)
    end

    it 'builds a time relation with out a group' do
      user1.time_spents.create(name: 'C#', amount: 3)
      expect(user1).to eql(TimeSpent.find_by(author_id: user1.id).author)
    end
  end

  it 'has many groups responses' do
    relation = described_class.reflect_on_association(:groups)
    expect(relation.macro).to eq :has_many
  end

  it 'has many time spents responses' do
    relation = described_class.reflect_on_association(:time_spents)
    expect(relation.macro).to eq :has_many
  end

  it 'should be valid' do
    u = User.new(name: 'test2', avatar: test_img_path)
    expect(u).to be_valid
  end

  it 'should not be valid' do
    u = User.new(name: '')
    expect(u).to_not be_valid
  end
end
