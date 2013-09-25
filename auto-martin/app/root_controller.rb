class RootController < UIViewController
  def didReceiveMemoryWarning
    super
  end

  def viewDidLoad
    view.backgroundColor = '#ebebf1'.to_color
    
    @add_video_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @add_video_button.setTitle('Add video', forState:UIControlStateNormal)
    @add_video_button.sizeToFit
    @add_video_button.addTarget(self, action:'tap_add_video_button', forControlEvents:UIControlEventTouchUpInside)
    @add_video_button.center = [self.view.frame.size.width / 2, 100]
    view.addSubview(@add_video_button)
    
    @upload_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @upload_button.setTitle('Upload all data', forState:UIControlStateNormal)
    @upload_button.sizeToFit
    @upload_button.addTarget(self, action:'tap_upload_button', forControlEvents:UIControlEventTouchUpInside)
    @upload_button.center = [self.view.frame.size.width / 2, 200]
    view.addSubview(@upload_button)
  end

  def viewDidUnload

  end
  
  def tap_add_video_button
    controller = VideoController.alloc.init
    controller.title = 'Video Details'
    self.navigationController.pushViewController(controller, animated:true)
  end
  
  def tap_upload_button
    controller = UploadController.alloc.init
    controller.title = 'Upload videos'
    self.navigationController.pushViewController(controller, animated:true)
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    true
  end
  
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    realign_components
  end
  
  def viewWillAppear(animated)
    realign_components
  end
  
  def realign_components
    @add_video_button.center = [self.view.frame.size.width / 2, 100]
    @upload_button.center = [self.view.frame.size.width / 2, 200]
  end
end