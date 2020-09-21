require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:user1) { User.create(name: 'test1', avatar: test_img_path) }

  describe 'create transaction' do
    it 'builds the time spent relation correctly' do
      group = user1.groups.build(name: 'dev1', selected_id: user1.id)
      path_to_file = Rails.root + 'spec/fixtures/img1.jpg'
      File.open(path_to_file) { |f| group.icon.store!(f) }
      group.save
      group1 = user1.groups.first
      group1.time_spents.create(name: 'art1', amount: 2, author_id: user1.id)
      expect(user1).to eql(TimeSpent.find_by(author_id: user1.id).author)
    end
  end

  it 'has many groups responses' do
    relation = described_class.reflect_on_association(:time_spents)
    expect(relation.macro).to eq :has_and_belongs_to_many
  end

  it 'has many time spents responses' do
    relation = described_class.reflect_on_association(:selected)
    expect(relation.macro).to eq :belongs_to
  end
  it 'should be valid with group' do
    user1.groups.create(name: 'dev1', icon: test_img_path)
    group1 = user1.groups.first
    u = group1.time_spents.new(name: 'test1', amount: 2, author_id: user1.id)
    expect(u).to be_valid
  end

  it 'should be valid with user' do
    u = user1.groups.build(name: 'dev1', icon: test_img_path)
    expect(u).to be_valid
  end

  it 'should not be valid with out user' do
    u = Group.new(name: 'dev1', icon: test_img_path)
    expect(u).to_not be_valid
  end

  it 'should not be valid with user' do
    u = user1.groups.build(name: '')
    expect(u).to_not be_valid
  end
end
