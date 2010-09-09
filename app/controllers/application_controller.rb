class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def session_expiry
    @time_left = (session[:expires_at] - Time.now).to_i
    unless @time_left > 0
      reset_session
      flash[:error] = 'Your session has expired. Please sign in.'
      redirect_to signin_url
    end
  end

  def update_activity_time
    session[:expires_at] = 5.minutes.from_now
  end
  

end
