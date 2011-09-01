class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  # before_filter :secure_domain_redirect, :except => ['session_expiry', 'update_activity_time']
  # 
  # def secure_domain_redirect
  #   if request.env['HTTP_REFERER'][0..4] == 'http:'
  #     redirect_to "https://lobotome.heroku.com#{request.env['PATH_INFO']}", :status => 301
  #   end
  # end

  # This method checks if the user has been idle for more than 5 minutes, and if so, signs the user out.
  
  def session_expiry
    expiration = session[:expires_at]
    if (expiration == nil) || ((expiration - Time.now).to_i <= 0)
      sign_out
      reset_session
      flash[:error] = 'Your session has expired. Please sign in.'
      redirect_to signin_url
    end
  end

  # This method updates the current user's session to expire 5 minutes from now. 
  # It is called after every user action (except sign out) to tell the system that the user is actively using the application.

  def update_activity_time
    session[:expires_at] = 5.minutes.from_now
  end
  
  # The following basically removes the default validation error css form executing
  
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    error_class = "fieldError"
    if html_tag =~ /<(input|textarea|select)[^>]+class=/
      style_attribute = html_tag =~ /class=['"]/
      html_tag.insert(style_attribute + 7, "#{error_class} ")
    elsif html_tag =~ /<(input|textarea|select)/
      first_whitespace = html_tag =~ /\s/
      html_tag[first_whitespace] = " class='#{error_class}' "
    end
    html_tag
  end

end