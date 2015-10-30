class TestController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: {:"message" => "hello"}.to_json }
      format.html
      end
  end

end
