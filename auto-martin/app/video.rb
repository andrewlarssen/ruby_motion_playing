class Video
  
  PROPERTIES = [:id, :filmed_on, :conversationalist, :location_gps, :location_town, :location_postcode]
  
  PROPERTIES.each do |prop|
    attr_accessor prop
  end
  
  def initialize(properties = {})
    properties.each do |key, value|
      self.send("#{key}=", value) if PROPERTIES.member? key.to_sym
    end
  end
  
  def initWithCoder(decoder)
    self.init
    PROPERTIES.each do |prop|
      saved_value = decoder.decodeObjectForKey(prop.to_s)
      self.self.send("#{prop}=", saved_value)
    end
    self
  end
  
  def encodeWithCoder(encoder)
    PROPERTIES.each do |prop|
      encoder.encodeObject(self.send(prop), forKey:prop.to_s)
    end
  end
  
  def save(current=false)
    defaults = NSUserDefaults.standardUserDefaults
    serialized = NSKeyedArchiver.archivedDataWithRootObject(self)
    
    defaults['current_video'] = serialized if current
    
    return if self.id.nil?
    
    defaults['video'] ||= {}
    defaults['video'][self.id] = serialized
    return self.id
  end
  
  def self.load(id)
    defaults = NSUserDefaults.standardUserDefaults
    defaults['video'] ||= {}
    
    if id == :current
      data = defaults['current_video']
    else
      data = defaults['video'][id]
    end
    
    NSKeyedUnarchiver.unarchiveObjectWithData(data) if data
  end
  
  def self.record_exists?(id)
    defaults = NSUserDefaults.standardUserDefaults
    defaults['video'] ||= {}
    
    defaults['video'][id].nil?
    
  end
  
  def self.videos_stored_locally_count
    defaults = NSUserDefaults.standardUserDefaults
    defaults['video'] ||= {}
    defaluts['video'].size
  end
end