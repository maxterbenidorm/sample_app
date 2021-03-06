class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  before_filter :signed_user, :only => [:new, :create]
  
  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save then
      flash[:success] = "Welcome to the Sample App!"
      sign_in @user, 0
      redirect_to @user
    else
      @user.password = ""
      @user.password_confirmation = ""
      @title = "Sign up"
      render 'new'
    end    
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update    
    if @user.update_attributes(params[:user]) then
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end    
  end
  
  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end
  
  def destroy
    user = User.find(params[:id])
    
    if current_user != user then
      user.destroy
      flash[:success] = "User destroyed."
    else
      flash[:error] = "You can't destroy yourself."
    end
    
    redirect_to users_path
  end
  
  private  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def signed_user
      redirect_to(root_path) unless !signed_in?
    end
end
