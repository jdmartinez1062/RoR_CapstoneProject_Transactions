RSpec.describe TimeSpent, type: :model do
    let!(:user1) { User.create(name: 'test1', avatar: test_img_path) }
  
    it 'has many groups responses' do
      relation = described_class.reflect_on_association(:groups)
      expect(relation.macro).to eq :has_and_belongs_to_many
    end
    
    it 'has many time spents responses' do
      relation = described_class.reflect_on_association(:author)
      expect(relation.macro).to eq :belongs_to
    end
    
    it 'should be valid with group' do 
        user1.groups.create(name: 'dev1', icon: test_img_path)
        group1 = user1.groups.first
        u = group1.time_spents.new(name: 'test1', amount: 2, author_id: user1.id)
        expect(u).to be_valid
    end
    
    it 'should be valid with group' do 
        u = user1.time_spents.new(name: 'test1', amount: 2)
        expect(u).to be_valid
    end

    it 'should not be valid with out user' do
        u = TimeSpent.new(name: 'test1', amount: 2)
        expect(u).to_not be_valid
    end

    it 'should not be valid with user' do
        u = TimeSpent.new(name: '')
        expect(u).to_not be_valid
    end
  end