require 'airport'

RSpec.describe Airport do
let(:weather) {double 'weather double'} #This double will only work if the Airport's initialize is given weather = Weather.new as an argument
subject {described_class.new([], weather)} #if we didn't do this, I think the weather double wouldn't be used because initialize would take the default arg of Weather.new instead of the double?
  
context "when the weather is sunny" do
    before do 
      allow(weather).to receive(:generate) { "sunny" } # stub. or allow(weather).to receive(:generate) { sunny } different syntax
    end
    
    it "a plane can land at an airport" do
      expect(subject.land("plane1")).to eq ["plane1"]
    end
      

    it "a second plane can land at the airport" do
      subject.land("plane1")
      expect(subject.land("plane2")).to eq ["plane1", "plane2"]
    end

    it "plane takes off and is not at airport" do
      subject.land("plane1")
      expect(subject.take_off).to eq([])   
    end

    it "one plane takes off and one is left in airport" do
      subject.land("plane1")
      subject.land("plane2")
      subject.take_off
      expect(subject.planes.length).to eq 1
    end

    it "confirms the plane is no longer at the airport after takeoff" do
      subject.land("plane2")
      subject.take_off
      expect(subject.plane_at_airport?("plane2")).to eq (false)
    end

    it "confirms if plane is at the airport" do
      subject.land("plane 1")
      expect(subject.plane_at_airport?("plane 1")).to eq(true)
    end

    it "returns weather is perfect for perfect weather" do
      # our stub on line 8 tells weather.generate to return sunny (which we set to 1). This means when weather_check is called, this method will run to the 'else' condition
      expect(subject.check_weather("land")).to eq "perfect for flying"
    end
  end

  context "when the weather is stormy" do
    
    before do 
      allow(weather).to receive(:generate) { "stormy" } #stub. We have already 'let' stormy equal 2 in line 5
    end

    it "won't allow takeoff if weather is stormy" do
      expect{ subject.take_off }.to raise_error ("cannot take off due to stormy weather")
    end

    it "won't allow landing if weather is stormy" do
      expect{ subject.land("plane1") }.to raise_error ("cannot land due to stormy weather")
    end
  end
end
