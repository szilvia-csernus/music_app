require 'rails_helper'

RSpec.describe Band, type: :model do
  
  it { should validate_presence_of(:name)}
  
  describe 'associations' do
    it {should have_many(:albums)}
    it { should have_many(:tags)}
    it { should have_many(:tracks)}
  end

end


