class PagesController < ApplicationController
  
  # These are all static pages, with the specified titles.
  
  def home
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def terms
    @title = "Terms"
  end

  def javascript_required
    @title = "Javascript Required"
  end

end
