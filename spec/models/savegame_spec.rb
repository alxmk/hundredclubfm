require 'spec_helper'

describe Savegame do
  
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :name => "New Savegame",
      :description => "A new savegame."
    }
  end
  
  it "should create a new instance given valid attributes" do
    @user.savegames.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @savegame = @user.savegames.create(@attr)
    end
    
    it "should have a user attribute" do
      @savegame.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @savegame.user_id.should == @user.id
      @savegame.user.should == @user
    end
    
  end
  
  describe "validations" do
    
    it "should reject blank names" do
      savegame = @user.savegames.create(@attr.merge(:name => " "))
      savegame.should_not be_valid
    end
    
    it "should reject short names" do
      short_name = "a"
      savegame = @user.savegames.create(@attr.merge(:name => short_name))
      savegame.should_not be_valid
    end
    
    it "should reject long names" do
      long_name = "a" * 31
      savegame = @user.savegames.create(@attr.merge(:name => long_name))
      savegame.should_not be_valid
    end
    
  end
   
end
