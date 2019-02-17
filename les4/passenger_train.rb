class Passenger_train < Train 
  def initialize(name)
  	super
  	@name = name
  	@type = "Пассажирский"
  	@vans << Passenger_van.new()
  end
end
