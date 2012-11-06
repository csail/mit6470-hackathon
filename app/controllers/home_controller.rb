class HomeController < ApplicationController
  def index
    @user = User.where(:id => session[:current_user_id]).first
    @users = User.all
    @problems = Problem.all
    #@solutions = Solution.all.where(:user_id => session[:current_user_id])
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
