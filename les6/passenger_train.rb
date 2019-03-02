class PassengerTrain < Train
  def initialize(number, type = "Passenger")
    super(number, type)
    @vans << PassengerVan.new()
  end
end
