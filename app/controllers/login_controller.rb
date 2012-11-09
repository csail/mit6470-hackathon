require "digest/sha2"

class LoginController < ApplicationController
  before_filter :require_login, :only => [:edit_email, :edit_name, :edit_zip_code, :edit_password, :delete_account]

  def index
    # make sure these values exist
    session[:autocomplete_email] ||= ""
  end

  def register
    # make sure these values exist
    session[:autocomplete_email] ||= ""
    session[:autocomplete_name] ||= ""
  end
  
  def submit_login
    # store the form data in case the user needs to fill it out again
    session[:autocomplete_email] = params[:email]

    # make sure all of the fields are filled out
    if params[:email] == "" or params[:email] == nil
      show_error("Please enter your email address.", true)
      return redirect_to :action => "index"
    end
    if params[:password] == "" or params[:password] == nil
      show_error("Please enter a password.", true)
      return redirect_to :action => "index"
    end

    # try to get the user with those credentials
    user = User.where(:email => params[:email]).select { |u| u.password == Digest::SHA512.hexdigest(u.salt + params[:password]) }.first

    # make sure that user exists
    if user == nil
      # redirect to the login page
      show_error("Invalid credentials.  Please check your email address and password and try again.", true)
      return redirect_to :action => "index"
    end

    # log in as that user
    session[:current_user_id] = user.id

    # redirect to the home page
    show_message("Welcome back, "+user.name+"!", true)
    return redirect_to :back
  end
  
  def submit_logout
    # sign the user out
    session[:current_user_id] = nil

    # redirect to the home page
    show_message("You are now logged out.", true)
    return redirect_to :back
  end
  
  def edit_email
    # validate the input
    if params[:email] == nil || params[:email].try(:empty?)
      show_error("Your email address cannot be empty.", true)
      return redirect_to :back
    end

    # edit the field and store it
    @user.email = params[:email]
    @user.save!

    # redirect to the home page
    show_message("Your email address has been updated.", true)
    return redirect_to :back
  end
  
  def edit_name
    # validate the input
    if params[:name] == nil || params[:name].try(:empty?)
      show_error("Your name cannot be empty.", true)
      return redirect_to :back
    end

    # edit the field and store it
    @user.name = params[:name]
    @user.save!

    # redirect to the home page
    show_message("Your name has been updated.", true)
    return redirect_to :back
  end

  def edit_password
    # validate the input
    if params[:password] == nil || params[:password].try(:empty?)
      show_error("Your password cannot be empty.", true)
      return redirect_to back
    end
    if params[:password] != params[:repassword]
      show_error("Your passwords do not match.", true)
      return redirect_to back
    end

    # edit the field and store it
    @user.password = Digest::SHA512.hexdigest(@user.salt + params[:password])
    @user.save!

    # redirect to the home page
    show_message("Your password has been updated.", true)
    return redirect_to :back
  end

  def delete_account
    # delete the account
    User.delete(@user.id)
    session[:current_user_id] = nil

    # redirect to the home page
    show_message("Your account has been deleted.", true)
    return redirect_to :controller => "home", :action => "index"
  end
  
  def submit_registration
    # store the form data in case the user needs to fill it out again
    session[:autocomplete_email] = params[:email]
    session[:autocomplete_name] = params[:name]

    # make sure all of the fields are filled out
    if params[:email] == nil || params[:email].try(:empty?)
      show_error("Please enter your email address.", true)
      return redirect_to :action => "register"
    end
    if params[:name] == nil || params[:name].try(:empty?)
      show_error("Please enter a display name.", true)
      return redirect_to :action => "register"
    end
    if params[:password] == nil || params[:password].try(:empty?)
      show_error("Please enter a password.", true)
      return redirect_to :action => "register"
    end
    if params[:repassword] == nil || params[:repassword].try(:empty?)
      show_error("Please re-type your password.", true)
      return redirect_to :action => "register"
    end

    # check if a user with that email address exists
    if User.where(:email => params[:email]).exists?
      show_error("Someone is already using that email address.", true)
      return redirect_to :action => "register"
    end

    # make sure the passwords match
    if params[:password] != params[:repassword]
      show_error("Your passwords do not match.", true)
      return redirect_to :action => "register"
    end

    # create the user
    user = User.new(:email => params[:email],
                    :name => params[:name])
    user.salt = SecureRandom.base64(8)
    user.password = Digest::SHA512.hexdigest(user.salt + params[:password])
    user.save!
    
    # log in as that user
    session[:current_user_id] = user.id

    # redirect to the home page`
    show_message("Thank you for signing up!", true)
    return redirect_to :back
  end

  def user
    begin
      @this_user = User.find(params[:user_id].to_i)
    rescue
      show_error("That user does not exist.", true)
      return redirect_to :back
    end
    if @user
      @this_is_me = (@this_user.id == @user.id)
    else
      @this_is_me = false
    end
  end

end
