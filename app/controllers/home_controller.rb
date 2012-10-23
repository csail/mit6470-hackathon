class HomeController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @users }
    end
  end

  autocomplete :users, :region
end
