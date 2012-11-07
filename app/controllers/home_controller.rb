class HomeController < ApplicationController
  def index
    @user = User.where(:id => session[:current_user_id]).first
    @users = User.all
    @categories = [
      {'category'=>'CSS', 'problems'=>Problem.where(:category=>"css")},
      {'category'=>'Javascript', 'problems'=>Problem.where(:category=>"js")},
      {'category'=>'SQL', 'problems'=>Problem.where(:category=>"sql")}
    ]
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @users }
    end
  end

  def backdoor
    @users = User.all
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @users }
    end
  end

end
