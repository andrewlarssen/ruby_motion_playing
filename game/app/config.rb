class Config
  
  SPEEDS = {
    :fast   => {:move => 0.1, :delay => 0.2, :duration =>  30},
    :medium => {:move => 0.2, :delay => 0.5, :duration =>  60},
    :slow   => {:move => 0.3, :delay => 0.7, :duration => 120}
  }
  
  def self.next_speed(current_speed)
    position = Config::SPEEDS.keys.index(current_speed) + 1
    position = 0 if position == Config::SPEEDS.keys.size
    return Config::SPEEDS.keys[position]
  end
end