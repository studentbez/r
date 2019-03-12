class CargoVan < Van
  def initialize(volume)
    @number = Array.new(7) { rand(0..9) }.join
    @type = 'Cargo'
    @place = volume.to_f.abs
    @taked_place = 0
  end

  def take_volume(volume)
    volume = volume.to_f.abs
    return unless @place <= 0 || @place < volume

    @place -= volume
    @taked_place += volume
  end
end
