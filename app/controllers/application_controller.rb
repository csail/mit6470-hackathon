require 'socket'
require 'json'
require 'cgi'

class ApplicationController < ActionController::Base
  protect_from_forgery

  # use this as a before filter for pages that require authentication
  def require_login
    if !@user
      flash.keep
      return redirect_to :controller => "login", :action => "index"
    end
  end

  # show a message
  def show_message(str, redirect=false)
    if redirect
      if flash[:message] == nil
        flash[:message] = [str]
      else
        flash[:message] += [str]
      end
    else
      if flash[:message] == nil
        flash.now[:message] = [str]
      else
        flash.now[:message] += [str]
      end
    end
  end

  # show an error message
  def show_error(str, redirect=false)
    if redirect
      if flash[:error] == nil
        flash[:error] = [str]
      else
        flash[:error] += [str]
      end
    else
      if flash[:error] == nil
        flash.now[:error] = [str]
      else
        flash.now[:error] += [str]
      end
    end
  end

  # look up the user in the database
  before_filter :lookup_user
  def lookup_user
    # check if the user is logged in
    if session[:current_user_id]
      begin
        @user = User.find(session[:current_user_id])
      rescue
        @user = nil
      end
    else
      @user = nil
    end
  end

  # this records the route for non login/registration pages -- called as a before filter for every request
  before_filter :record_route
  def record_route
    # if there is no stored route, just store the home page
    session[:last_params] ||= { :last_controller => "home", :last_action => "index" }

    # clear the autocomplete stuff for the login/registration forms
    session[:autocomplete_email] = ""
    session[:autocomplete_name] = ""

    # store the route
    session[:last_params] = params
  end

end
