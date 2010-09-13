class PagesController < ApplicationController
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

  def privacy
    @title = "Privacy"
  end

end
