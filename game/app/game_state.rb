class GameState
  
  @@instance = nil
    
  attr_accessor :score
  
  attr_accessor :speed
  
  def self.instance
    @@instance ||= self.new()
    return @@instance
  end
  
  def initialize
    @speed = :medium
  end
end