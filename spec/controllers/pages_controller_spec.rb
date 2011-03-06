require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => "Home")
    end
    
    describe "for signed-in users" do
      
      before :each do
        @user = test_sign_in(Factory(:user))
      end
    
      it "should have the correct microposts number" do
        10.times do
          Factory(:micropost, :user => @user)
        end
        
        get 'home'
        response.should have_selector('span.microposts', :content => @user.microposts.count.to_s + " microposts")
      end
      
      it "should say micropost if the user only have 1 micropost" do
        Factory(:micropost, :user => @user)
        get 'home'
        response.should have_selector('span.microposts', :content => "1 micropost")
      end
    
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => "Contact")
    end
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title", :content => "About")
    end
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title", :content => "Help")
    end
  end
end
