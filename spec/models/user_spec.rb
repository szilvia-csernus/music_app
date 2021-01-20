require 'rails_helper'

#user_test = User.create!(email: "csernus@csernus.com", password: "hello123")

RSpec.describe User, type: :model do
  
  let(:user_test2) { User.create!(email: "szilvia@csernus.com", password: "hello123") }

  it { should validate_presence_of(:email)}
  it { should validate_uniqueness_of(:email)}

  it "fails validation if password length is <= 6" do
      short_pw_user = User.new( email: "hi@hello.com", password: "hello")
      expect(short_pw_user).not_to be_valid
  end

  it 'fails validation with no password_digest expecting a specific message' do
    no_pw_user = User.new(email: "hi@hi.com")
    no_pw_user.valid? #sets the error hash
    expect(no_pw_user.errors[:password_digest]).to include('Password can\'t be blank')
  
  end

  context "#is_password?" do
    it "returns true if the right password is passed" do
      expect(user_test2.is_password?("hello123")).to be true
    end

    it "returns false if the wrong password is passed" do
      expect(user_test2.is_password?("hi123")).to be false
    end
  end

    
  it "#reset_session_token! sets a new session token when called" do
    user_test2.session_token = 123
    user_test2.reset_session_token!
    expect(user_test2.session_token).not_to be(123)
  end

  it "::find_by_credentials finds user with given email&password" do
    user_test3 = User.create!(email: "szilvia1@csernus.com", password: "hello123")
    user_3 = User.find_by_credentials("szilvia1@csernus.com", "hello123")
    expect(user_3).to eq(user_test3)
  end

  it "::find_by_credentials will not return a user if called with wrong credentials" do
    user_4 = User.find_by_credentials("valaki@valami.com", "hello123")
    expect(user_4).to be nil
  end
  
  describe 'associations' do
    it { should have_many(:tags)}
    it { should have_many(:notes)}
  end
end



