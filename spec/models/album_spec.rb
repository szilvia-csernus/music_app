require 'rails_helper'

RSpec.describe Album, type: :model do
  
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:year)}
  
  describe 'associations' do
    it { should have_many(:tracks)}
    it { should have_many(:tags)}
    it { should belong_to(:band)}
  end

end
