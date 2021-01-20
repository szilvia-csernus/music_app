require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Band, type: :model do
  
  it { should validate_presence_of(:name)}
  
  it 'fails validation with no name expecting a specific message' do
    no_name_band = Band.new()
    no_name_band.valid?
    expect(no_name_band.errors[:name]).to include('can\'t be blank')
  
  end
end

RSpec.describe Band do
  
  describe 'associations' do
    it {should have_many(:albums)}
    it { should have_many(:tags)}
    it { should have_many(:tracks)}
  end

end


