class TestController < ApplicationController

  def index
    @outputStorageCode = Array.new
    currentStorageCode = ""
    letters = ('A'..'F').to_a
    xCoordinates = ('01'..'02').to_a
    yCoordinates = ('01'..'15').to_a
    for letter in letters
      for xCoordinate in xCoordinates
        for yCoordinate in yCoordinates
          currentStorageCode.concat("<div>" + letter + "-" + xCoordinate + "-" + yCoordinate + "</div>")
        end
      end
    end
    @outputStorageCode.push(currentStorageCode)
  end

end
