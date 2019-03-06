class CargoTrain < Train 
  def initialize(number, type = "Cargo")
    super(number, type)
    @vans << CargoVan.new(100)
  end
end
