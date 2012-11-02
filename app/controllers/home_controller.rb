class HomeController < ApplicationController
  def index
    @users = User.all
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
