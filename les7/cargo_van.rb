class CargoVan < Van
  def initialize(volume)
    @number = 7.times.map { rand(0..9) }.join
    @type = "Cargo"
    @place = volume.to_f.abs
    @taked_place = 0
  end

  def take_volume(volume)
    volume = volume.to_f.abs
    if @place > 0 && @place >= volume
      @place -= volume
      @taked_place += volume
    end
  end
end
