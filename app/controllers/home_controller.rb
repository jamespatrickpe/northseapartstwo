class HomeController < ApplicationController

  layout 'application'
  before_action :authenticate_access!, only: [ ]

  def index
  end

  def parts_library
  end

  def become_a_supplier
  end

  def become_a_retailer
  end

  def store_locations
  end

  def about_us
  end
end
