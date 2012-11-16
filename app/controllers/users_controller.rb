class UsersController < ApplicationController
  before_filter :require_login, :only => [:show]

  # GET /users/1
  def show
    @user = User.find_by_param params[:id]

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /users
  def create
    @user = User.new params[:user]
    # NOTE: the first user is an admin, must bestow admin on everyone else
    @user.admin = (User.count == 0)

    respond_to do |format|
      if @user.save
        set_session_current_user @user
        format.html { redirect_to session_url }
      else
        format.html { render action: :new }
      end
    end
  end
end
