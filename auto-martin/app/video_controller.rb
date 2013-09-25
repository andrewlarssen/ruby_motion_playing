class VideoController < Formotion::FormController
  
  def init    
    @form = Formotion::Form.new()
    
    @form.build_section do |section|
      section.title = "Video information"

      section.build_row do |row|
        row.title       = "Video ID"
        row.placeholder = "id"
        row.type        = :string
        row.key         = :id
      end
      
      section.build_row do |row|
        row.title       = "Filmed on"
        row.type        = :date
        row.key         = :filmed_on
        row.value       = Time.now.to_i
        row.format      = :medium
      end
      
      section.build_row do |row|
        row.title       = "GPS Location"
        row.type        = :string
        row.key         = :location_gps
        row.placeholder = 'x,y'
        @gps_row = row
      end
      
      section.build_row do |row|
        row.title       = "Town"
        row.type        = :string
        row.key         = :location_town
        @town_row = row
      end
      
      section.build_row do |row|
        row.title       = "Postcode"
        row.type        = :string
        row.key         = :location_postcode
        @postcode_row = row
      end
      
      section.build_row do |row|
        row.title       = "Conversationalist"
        row.key         = :conversationalist
        row.type        = :picker
        row.items       = ['Bill', 'Harry', 'Fred']
        row.value       = 'Harry'
      end
      
      section.build_row do |row|
        row.title       = "Notes"
        row.type        = :text
        row.key         = :notes
        row.row_height  = 100
      end
    end
    
    @form.build_section do |section|
      section.build_row do |row|
        row.title       = "Reset location"
        row.type        = :button
        row.key         = :reset_location
      end
      
      section.build_row do |row|
        row.title       = "Add participant"
        row.type        = :button
        row.key         = :add_participant
      end
      
      section.build_row do |row|
        row.title       = "Save"
        row.type        = :submit
      end
    end
    
    @form.on_submit do
      self.submit
    end
    
    @form.row(:reset_location).on_tap { set_location }
    
    @form.row(:add_participant).on_tap do
      controller = ParticipantController.alloc.init
      controller.title = 'Participant Details'
      self.navigationController.pushViewController(controller, animated:true)
    end
    
    #Testing code - needs removed
    $video_form = @form
    
    super.initWithForm(@form)
  end

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    # got a new location
    location = CLLocation.alloc.initWithLatitude(newLocation.coordinate.latitude, longitude:newLocation.coordinate.longitude)
    @gps_row.value = "#{newLocation.coordinate.latitude},#{newLocation.coordinate.longitude}"
    @my_geocoder = CLGeocoder.alloc.init
    
    @my_geocoder.reverseGeocodeLocation(location, completionHandler:lambda do |placemarks, error|
      if (error.nil? && placemarks.count > 0)
        placemark = placemarks.objectAtIndex(0)
        @town_row.value = placemark.locality
        @postcode_row.value = placemark.postalCode
        @my_location_manager.stopUpdatingLocation
      end
    end)
  end

  def locationManager(manager, didFailWithError:error)
    p "Failed"
  end

  def viewDidLoad
    super
    
    set_location
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Save", style: UIBarButtonItemStyleDone, target:self, action:'submit')
  end

  def viewDidUnload
    @my_location_manager.stopUpdatingLocation
    @my_location_manager = nil
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    true
  end
  
  def set_location
    if (CLLocationManager.locationServicesEnabled)
      @my_location_manager = CLLocationManager.alloc.init
      @my_location_manager.delegate = self
    
      @my_location_manager.purpose = "To provide functionality based on user's current location" 
      @my_location_manager.startUpdatingLocation
    else
      p "Location services are not enabled."
    end
  end
  
  def submit
    form_data = @form.render
    p form_data.inspect
  end
end