class ParticipantController < Formotion::FormController
  
  def init    
    @form = Formotion::Form.new()
    
    @form.build_section do |section|
      section.title = "Participant information"

      section.build_row do |row|
        row.title       = "First name"
        row.placeholder = "Joe"
        row.type        = :string
        row.key         = :first_name
      end
      
      section.build_row do |row|
        row.title       = "Last Name"
        row.placeholder = "Bloggs"
        row.type        = :string
        row.key         = :last_name
        @postcode_row = row
      end
      
      section.build_row do |row|
        row.title       = "Date of Birth"
        row.type        = :date
        row.key         = :date_of_birth
        row.format      = :medium 
      end
      
      section.build_row do |row|
        row.title       = "Postcode"
        row.type        = :string
        row.key         = :postcode
        @postcode_row = row
      end
      
      section.build_row do |row|
        row.title       = "Mobile phone network"
        row.type        = :picker
        row.items       = ['3', 'O2', 'EE', 'Virgin', 'Orange', 'Vodaphone', 'T-Mobile', 'GifGaf']
      end
      
      section.build_row do |row|
        row.title       = "Group"
        row.type        = :picker
        row.items       = ['A', 'B', 'C1', 'C2', 'D', 'E']
      end
      
      section.build_row do |row|
        row.title       = "Image"
        row.type        = :image
        row.key         = :participant_image
      end
    end
    
    @form.build_section do |section|
      section.build_row do |row|
        row.title       = "Save"
        row.type        = :submit
      end
    end
    
    @form.on_submit do
      self.submit
    end
    #Testing code - needs removed
    $participant_form = @form
    
    super.initWithForm(@form)
  end

  def viewDidLoad
    super
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Save", style: UIBarButtonItemStyleDone, target:self, action:'submit')
  end

  def viewDidUnload
    
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    true
  end
  
  def submit
    form_data = @form.render
    p form_data.inspect
    
    #Image stuff
    raw_image = form_data[:participant_image]
    if raw_image
      full_filename = File.join(App.documents_path,'foo.png')
      UIImagePNGRepresentation(raw_image).writeToFile(full_filename, atomically:true)
    end
  end
end