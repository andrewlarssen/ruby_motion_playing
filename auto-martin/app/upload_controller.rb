class UploadController < UIViewController
  def didReceiveMemoryWarning
    super
  end

  def viewDidLoad
    view.backgroundColor = '#ebebf1'.to_color
    
    @counter = UITextField.alloc.initWithFrame(CGRectZero)
    set_counter
    @counter.enabled = false
    @counter.sizeToFit
    @counter.center = [self.view.frame.size.width / 2, 100]
    view.addSubview(@counter)
    
    @upload_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @upload_button.setTitle('Upload all saved records', forState:UIControlStateNormal)
    @upload_button.sizeToFit
    @upload_button.addTarget(self, action:'tap_upload_button', forControlEvents:UIControlEventTouchUpInside)
    @upload_button.center = [self.view.frame.size.width / 2, 200]
    view.addSubview(@upload_button)
  end

  def viewDidUnload

  end
  
  def tap_upload_button
    App.alert("Uploading...", {cancel_button_title: "OK", message: "Uploading and then removing all records"})
    # UPLOAD HERE + REMOVE DELAY
    set_counter
    App.run_after(10) {  App.alert("Upload Complete", {cancel_button_title: "OK", message: "All records have been uploaded"})   }
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    true
  end
  
  def set_counter
    @counter.text = "Videos to upload: #{rand(10)}"
  end
  
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    realign_components
  end
  
  def viewWillAppear(animated)
    realign_components
  end
  
  def realign_components
    @counter.center = [self.view.frame.size.width / 2, 100]
    @upload_button.center = [self.view.frame.size.width / 2, 200]
  end
end