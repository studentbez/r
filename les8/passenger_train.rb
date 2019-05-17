class PassengerTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, /^[A-Z0-9]{3}(-| )[A-Z0-9]{2}$/

  def initialize(number, type = 'Passenger')
    super(number, type)
    @vans << PassengerVan.new(54)
  end
end
