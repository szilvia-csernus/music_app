require 'rails_helper'

RSpec.describe Track, type: :model do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:ord)}
  
  describe 'associations' do
    it { should have_many(:notes)}
    it { should have_many(:tags)}
    it { should belong_to(:album)}
  end
end
