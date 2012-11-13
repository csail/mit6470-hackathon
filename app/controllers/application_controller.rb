class ApplicationController < ActionController::Base
  protect_from_forgery
  authenticates_using_session

  # use this as a before filter for pages that require authentication
  def require_login
    bounce_user unless current_user
  end

  # require admin privileges
  def require_admin
    bounce_user unless current_user and current_user.admin
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
end
