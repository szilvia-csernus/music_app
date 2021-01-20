require 'rails_helper'
require 'application_controller'

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
        post :create, params: { user: {email: "email@email.com", password: "hello123" } }
        expect(response).to redirect_to(root_url)
        end
    end

  end

  describe "GET #index" do
    
    let(:user) { User.create!(email: "hi2@hi.hi", password: "hihihihi", activated: true, admin: true)}
    
    it "it renders the users index page" do
        #allow(user).to receive(:require_current_user!).and_return(true)
        #allow(user).to receive(:require_current_user_admin!).and_return(true)
    
        get :index

        expect(response).to render_template(:index)
    end

  end
end

