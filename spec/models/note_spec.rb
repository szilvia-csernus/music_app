require 'rails_helper'

RSpec.describe Note, type: :model do
  
  it { should validate_presence_of(:text)}
  it { should validate_presence_of(:track_id)}
  it { should validate_presence_of(:user_id)}
  
  describe 'associations' do
    it { should belong_to(:track)}
    it { should belong_to(:user)}
  end
end
