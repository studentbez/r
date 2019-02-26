class PassengerTrain < Train
  def initialize(name, number)
    super
    @number = number
    @name = name
    @type = "Пассажирский"
    @vans << PassengerVan.new()
  end
end
