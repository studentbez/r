class CargoTrain < Train 
  def initialize(name, number)
    super
    @number = number
    @name = name
    @type = "Грузовой"
    @vans << CargoVan.new()
  end
end
