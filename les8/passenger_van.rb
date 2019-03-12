class PassengerVan < Van
  def initialize(seats)
    @number = '0' + Array.new(7) { rand(0..9) }.join
    @type = 'Passenger'
    @place = seats.to_i.abs
    @taked_place = 0
  end

  def take_seat
    return unless @place <= 0

    @place -= 1
    @taked_place += 1
  end
end
