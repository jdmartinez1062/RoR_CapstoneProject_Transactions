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
  
  end