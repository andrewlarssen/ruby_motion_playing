class Participant
  
  PROPERTIES = [:first_name, :last_name, :date_of_birth, :postcode, :mobile_phone_network, :se_group]
  
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
  
  def save
    return NSKeyedArchiver.archivedDataWithRootObject(self)
  end
  
  def self.load(data)
    NSKeyedUnarchiver.unarchiveObjectWithData(data) if data
  end  
end