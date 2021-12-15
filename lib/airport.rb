require 'weather'

class Airport

  attr_reader :planes

  def initialize(planes = [], weather = Weather.new) #because we've initialized with flexible arg of weather =, it means we can set this using a double in the tests. I think this is partly why we do this?
    @planes = planes
    @weather = weather
  end

  def land(plane)
    check_weather("land")
    @planes.push(plane)
  end

  def take_off
    check_weather("take off")
    @planes.pop
    @planes
  end

  def plane_at_airport?(plane)
    @planes.include?(plane)
  end

  def check_weather(action)
    if @weather.generate == "stormy"
      raise "cannot #{action} due to stormy weather"
    else
      "perfect for flying"
    end
  end

end
