class PagesController < ApplicationController
  def index
  end
  def aboutUs
    render "pages/about_us"
  end
  def contactUs
    render "pages/contact_us"
  end
end
