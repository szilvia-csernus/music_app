require 'rails_helper'

RSpec.describe Tag, type: :model do
  
  describe 'associations' do
    it { should belong_to(:tagging)}
    it { should belong_to(:user)}
  end
end
