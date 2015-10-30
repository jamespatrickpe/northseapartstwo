class TestController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token #Need this for AJAX. AJAX Does not work without this.

  def index
    @accesses = Access.all
    respond_to do |format|
      format.json { render json: {:"message" => "hello"}.to_json }
      format.html
    end

  end

  def try_ajax_function

    @accesses = Access.all
    respond_to do |format|
      format.json { render json: {:accesses => @accesses}}
      format.html
    end

  end

end
