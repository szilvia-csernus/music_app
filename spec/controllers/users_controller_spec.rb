require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password" do
        post :create, params: { user: {email: "email@email.com"} } # no password
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, params: { user: {email: "email@email.com", password: "hello"} } # too short pw
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to bands index on success" do
        test_user = build(:user)
        post :create, params: { user: {email: test_user.email, password: test_user.password } }
        expect(response).to redirect_to(root_url)
        end
    end

  end

  describe "GET #activate" do

    let(:test_user) { build(:user)}
    
    it "activates the user's account" do
        test_user.set_activation_token
        test_user.save
        
        get :activate, params: {activation_token: test_user.activation_token}
        user = User.find_by(id: test_user.id)
        expect(user.activated?).to be true
      end
    it "http response is 200 successful after activation" do
      expect(response).to have_http_status(200)
    end

    it "does not activate user's account if activation_token is invalid" do
      test_user.set_activation_token
      test_user.save 
      
      get :activate, params: {activation_token: 123} # invalid token
      user = User.find_by(id: test_user.id)
      expect(user.activated?).to be false
      expect(flash[:errors]).to be_present
    end


  end

  describe "GET #index" do
   
    it "it renders the users index page for admin users" do
      allow(controller).to receive(:require_current_user!).and_return(true)
      allow(controller).to receive(:require_current_user_admin!).and_return(true)
      
      get :index
      
      expect(response).to render_template(:index)

    end
 
  end

  describe "GET #flip_admin_rights" do

  let(:test_user) { create(:user)}
    
    it "sets the users account to admin: true" do
        allow(controller).to receive(:require_current_user!).and_return(true)
        allow(controller).to receive(:require_current_user_admin!).and_return(true)
        
        get :flip_admin_rights, params: {id: test_user.id}
        user = User.find_by(id: test_user.id)
        expect(user.admin?).to be true
      end

    it "http response is 200 successful after action" do
      expect(response).to have_http_status(200)
    end

    it "sets the account back to admin:false" do
      allow(controller).to receive(:require_current_user!).and_return(true)
      allow(controller).to receive(:require_current_user_admin!).and_return(true)

      get :flip_admin_rights, params: {id: test_user.id}
        user = User.find_by(id: test_user.id)
        expect(user.admin?).to be true
      get :flip_admin_rights, params: {id: user.id}
        user_2 = User.find_by(id: user.id)
        expect(user_2.admin?).to be false
    end

    it "returns with an error message if doesn't find user" do
      allow(controller).to receive(:require_current_user!).and_return(true)
      allow(controller).to receive(:require_current_user_admin!).and_return(true)
        
      get :flip_admin_rights, params: {id: -1} # invalid user.id is given
      user = User.find_by(id: test_user.id) 
      expect(flash[:errors]).to be_present
    end
    
  end
end

