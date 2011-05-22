require 'spec_helper'

describe SavegamesController do
  render_views

  describe "GET 'new'" do
    
    describe "when no user signed in" do
      
      it "should redirect to the sign-in path" do
        get :new
        response.should redirect_to(signin_path)
      end
      
      it "should flash a notice asking the user to sign in" do
        get :new
        flash[:notice].should =~ /please sign in/i
      end
      
    end
    
    describe "when user is signed-in" do
      
      before(:each) do
        test_sign_in(Factory(:user))
      end
      
      it "should be successful" do
        get :new
        response.should be_success
      end
      
      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "New Save")
      end 
    
    end
    
  end
  
  describe "POST 'create'" do
    
    describe "when no user signed-in" do
      
      before(:each) do
        @attr = {
          :name => "A Save",
          :description => "Some save."
        }
      end
      
      it "should not create a save-game" do
        lambda do
          post :create, :savegame => @attr
        end.should_not change(Savegame, :count)
      end
      
      it "should redirect to the sign-in path" do
        post :create, :savegame => @attr
        response.should redirect_to(signin_path)
      end
      
      it "should flash a notice asking the user to sign in" do
        post :create, :savegame => @attr
        flash[:notice].should =~ /please sign in/i
      end
      
    end
    
    describe "when a user is signed-in" do
      
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        @attr = {
          :name => "A save",
          :description => "Some save-game"
        }
      end
      
      it "should create a savegame" do
        lambda do
          post :create, :savegame => @attr
        end.should change(Savegame, :count).by(1)
      end
        
      it "should redirect to the savegame show path" do
        post :create, :savegame => @attr
        response.should redirect_to(savegame_path(assigns(:savegame)))
      end
      
    end
    
  end
  
  describe "GET 'edit'" do
    
    describe "when not signed in" do
      
      before(:each) do
        user = Factory(:user)
        @savegame = Factory(:savegame, :user_id => user.id)
      end
      
      it "should redirect to the sign-in page" do
        get :edit, :id => @savegame
        response.should redirect_to(signin_path)
      end
      
      it "should flash a notice asking the user to sign in" do
        get :edit, :id => @savegame
        flash[:notice].should =~ /please sign in/i
      end
      
    end
    
    describe "when signed in as another user" do
      
      before(:each) do
        save_owning_user = Factory(:user)
        @savegame = Factory(:savegame, :user_id => save_owning_user.id)
        non_owning_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(non_owning_user)
      end
      
      it "should redirect to the savegame index" do
        get :edit, :id => @savegame
        response.should redirect_to(savegames_path)
      end
      
      it "should flash a notice telling the user they don't own the save" do
        get :edit, :id => @savegame
        flash[:notice].should =~ /not your save/i
      end
      
    end
    
    describe "when signed in as the correct user" do
      
      before(:each) do
        user = Factory(:user)
        test_sign_in(user)
        @savegame = Factory(:savegame, :user_id => user.id)
      end
      
      it "should be successful" do
        get :edit, :id => @savegame
        response.should be_success
      end
      
      it "should have the right title" do
        get :edit, :id => @savegame
        response.should have_selector("title", :content => "Edit Save")
      end
      
    end
    
    describe "PUT 'update'" do
      
      before(:each) do
        user = Factory(:user)
        test_sign_in(user)
        @savegame = Factory(:savegame, :user_id => user.id)
      end
      
      describe "failure" do
        
        before(:each) do
          @attr = {
            :name => "",
            :description => ""
          }
        end
        
        it "should render the 'edit' page" do
          put :update, :id => @savegame, :savegame => @attr
          response.should render_template('edit')
        end
        
        it "should have the right title" do
          put :update, :id => @savegame, :savegame => @attr
          response.should have_selector("title", :content => "Edit Save")
        end
        
      end
      
      describe "success" do
        
        before(:each) do
          @attr = {
            :name => "New save name",
            :description => "New save description"
          }
        end
        
        it "should change the user's attributes" do
          put :update, :id => @savegame, :savegame => @attr
          @savegame.reload
          @savegame.name.should == @attr[:name]
          @savegame.description.should == @attr[:description]
        end
        
        it "should redirect to the savegame index" do
          put :update, :id => @savegame, :savegame => @attr
          response.should redirect_to(savegames_path)
        end
        
        it "should have a flash message" do
          put :update, :id => @savegame, :savegame => @attr
          flash[:success].should =~ /updated/i
        end
        
      end
      
    end
    
  end

end
