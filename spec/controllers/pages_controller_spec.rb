require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    
    before(:each) do
      get :home
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "Home")
    end
    
  end

  describe "GET 'contact'" do
    
    before(:each) do
      get 'contact'
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "Contact")
    end
    
  end

  describe "GET 'about'" do
    
    before(:each) do
      get 'about'
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "About")
    end
    
  end

end
