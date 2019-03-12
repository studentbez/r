class PassengerTrain < Train
  def initialize(number, type = 'Passenger')
    super(number, type)
    @vans << PassengerVan.new(54)
  end
end
