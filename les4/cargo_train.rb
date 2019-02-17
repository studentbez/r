class Cargo_train < Train 
  def initialize(name)
    super
    @name = name
    @type = "Грузовой"
    @vans.push(Cargo_van.new(1))
  end
end
