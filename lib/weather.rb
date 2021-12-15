class Weather

  def generate
    weather_types = ["rainy", "sunny", "stormy"]
    weather_types.sample #this method returns rainy, sunny or stormy.
    # Kernel.rand(weather_types.length) # this method returns a number (0, 1, 2 as length of array is 0,1,2)
  end

end

#p weather = Weather.new
#p weather.generate
