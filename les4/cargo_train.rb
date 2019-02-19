class CargoTrain < Train 
  def initialize(name)
    super
    @name = name
    @type = "Грузовой"
    @vans << CargoVan.new()
  end
end
