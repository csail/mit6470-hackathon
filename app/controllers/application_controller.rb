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

  # look up a city name by region
  def get_city_name(address)
    begin
      sock = TCPSocket.open("maps.googleapis.com", 80)
      sock.print("GET /maps/api/geocode/json?address=#{CGI::escape(address)}&sensor=false HTTP/1.0\r\n\r\n")
      response = sock.read
      response = response[response.index("\r\n\r\n")+4, response.length]
      first_result = JSON.parse(response)["results"][0]
      for component in first_result["address_components"]
        if component["types"].index("locality") != nil
          return component["long_name"]
        end
      end
    rescue
    end
    return ""
  end

  # get the distance between two regions in meters
  def get_distance(address1, address2)
    begin
      sock = TCPSocket.open("maps.googleapis.com", 80)
      sock.print("GET /maps/api/distancematrix/json?origins=#{CGI::escape(address1)}&destinations=#{CGI::escape(address2)}&mode=driving&sensor=false HTTP/1.0\r\n\r\n")
      response = sock.read
      response = response[response.index("\r\n\r\n")+4, response.length]
      return JSON.parse(response)["rows"][0]["elements"][0]["distance"]["value"].to_i
    rescue
    end
    return 0
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

    # make sure we're on an actual non-login/registration page
    #return if params[:controller] == "login" && params[:action] == "index"
    #return if params[:controller] == "login" && params[:action] == "register"
    #return if params[:controller] == "login" && params[:action] == "register"
    #return if params[:controller] == "dict" && params[:action] == "upload"
    #return if params[:controller] == "dict" && params[:action] == "done_uploading"
    #return if params[:controller] == "quiz" && params[:action] == "newword"
    #return if params[:controller] == "quiz" && params[:action] == "learn"
    #return if params[:controller] == "quiz" && params[:action] == "json"
    #return if params[:controller] == "quiz" && params[:action] == "quiz"
    #return if params[:controller] == "quiz" && params[:action] == "play"
    #return if params[:controller] == "quiz" && params[:action] == "submit_score"
    #return if !request.get?

    # clear the autocomplete stuff for the login/registration forms
    session[:autocomplete_email] = ""
    session[:autocomplete_name] = ""
    session[:autocomplete_region] = ""

    # store the route
    session[:last_params] = params
  end

end
