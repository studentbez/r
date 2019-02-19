class PassengerTrain < Train 
  def initialize(name)
  	super
  	@name = name
  	@type = "Пассажирский"
  	@vans << PassengerVan.new()
  end
end
