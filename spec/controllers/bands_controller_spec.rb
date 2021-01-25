require 'rails_helper'

RSpec.describe BandsController, type: :controller do

    before do 
        allow(controller).to receive(:require_current_user!).and_return(true)
        allow(controller).to receive(:require_current_user_admin!).and_return(true)
    end
    
    describe "GET #index" do
   
        it "it renders bands index page for logged in users" do
            
            get :index
            
            expect(response).to render_template(:index)
        end
 
    end

    describe "GET #show" do

        it "it renders bands show page for logged in users" do
            test_band = FactoryBot.create(:band)
            # test_user = User.create(email: "#{Time.now}@email.com", password: "password")
            test_user = create(:user)
            tag = Tag.create(user_id: test_user.id, tagging_id: test_band.id, tagging_type: "Band")
            allow(controller).to receive(:current_user).and_return(test_user)

            get :show, params: { id: test_band.id, tag: tag}
            
            expect(response).to render_template(:show)
        end

        it "it redirects to bands index page if band is not found" do
            test_band = FactoryBot.create(:band)
            test_user = create(:user)
            tag = Tag.create(user_id: test_user.id, tagging_id: test_band.id, tagging_type: "Band")
            allow(controller).to receive(:current_user).and_return(test_user)

    
            begin
                get :show, params: { id: -1, tag: tag}   # invalid band id
            rescue
                ActiveRecord::RecordNotFound
            end
            
            expect(response).to redirect_to(bands_url)
        end
 
    end

    describe "GET #new" do
        
        it "renders the new template" do
            get :new, {}
            expect(response).to render_template("new")
            expect(response).to have_http_status(200)
        end
    end

    describe "POST #create" do
        
        it "with invalid name it will not create band" do
            post :create, params: { band: {name: ""} } # no name
            expect(response).to render_template("new")
            expect(flash[:errors]).to be_present
        end


        it "with valid params it creates band and redirects user to bands index on success" do
            post :create, params: { band: {name: "Rolling Stones"} }
            expect(response).to redirect_to(bands_url)
        end
    end

    describe "GET #edit" do

        it "it renders band's edit page for logged in users" do
            test_band = FactoryBot.create(:band)
            test_user = create(:user)
            allow(controller).to receive(:current_user).and_return(test_user)

            get :edit, params: { id: test_band.id}
            
            expect(response).to render_template(:edit)
        end

        it "it redirects to bands index page if band is not found" do
            test_band = FactoryBot.create(:band)
            test_user = create(:user)
            allow(controller).to receive(:current_user).and_return(test_user)

    
            begin
                get :edit, params: { id: -1}   # invalid band id
            rescue
                ActiveRecord::RecordNotFound
            end
            
            expect(response).to redirect_to(bands_url)
        end
 
    end

    describe "PATCH #update" do

        
        it "with invalid name it will not update band" do
            test_band = FactoryBot.create(:band)
            test_user = create(:user)  
            allow(controller).to receive(:current_user).and_return(test_user)
            
            patch :update, params: {id: test_band.id, band: {name: ""} } # no name
            expect(response).to render_template("edit")
            expect(flash[:errors]).to be_present
        end


        it "with valid params it creates band and redirects user to band's show page on success" do
            test_band = FactoryBot.create(:band)
            test_user = create(:user)  
            allow(controller).to receive(:current_user).and_return(test_user)

            patch :update, params: {id: test_band.id,  band: {name: "Rolling Stones"} }
            expect(response).to redirect_to(band_url(test_band))
        end
    end

    describe "POST #destroy" do
        
        it "it redirects to band's index page upon successful destroy" do
            test_band = FactoryBot.create(:band)
            test_user = create(:user)  
            allow(controller).to receive(:current_user).and_return(test_user)
            
            delete :destroy, params: { id: test_band.id}
            
            expect(response).to redirect_to(bands_url)
        end

        it "it redirects to bands index page if band is not found" do
            test_band = FactoryBot.create(:band)
            test_user = create(:user)  
            allow(controller).to receive(:current_user).and_return(test_user)
            
            begin
                delete :destroy, params: { id: -1}   # invalid band id
            rescue
                ActiveRecord::RecordNotFound
            end
            
            expect(response).to redirect_to(bands_url)
        end
 
    end


end
