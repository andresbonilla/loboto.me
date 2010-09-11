class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def session_expiry
    expiration = session[:expires_at]
    if (expiration == nil) || ((expiration - Time.now).to_i <= 0)
      sign_out
      reset_session
      flash[:error] = 'Your session has expired. Please sign in.'
      redirect_to signin_url
    end
  end

  def update_activity_time
    session[:expires_at] = 5.minutes.from_now
  end
  




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
