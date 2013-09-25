class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    @root_controller = RootController.alloc.init
    @root_controller.title = 'Auto Martin'
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@root_controller)

    @window.rootViewController = @navigation_controller
    
    #Splash Screen
    image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed(launch_image_name))
    image_view.frame = UIScreen.mainScreen.bounds
    @window.rootViewController.view.addSubview(image_view)
    @window.rootViewController.view.bringSubviewToFront(image_view)
    
    @window.makeKeyAndVisible
    
    # fade out splash image
    fade_out_timer = 1.0    
    UIView.transitionWithView(@window, duration:fade_out_timer, options:UIViewAnimationOptionTransitionCurlUp, animations: lambda { image_view.alpha = 0 }, completion: lambda do |finished|
      image_view.removeFromSuperview
      image_view = nil
      UIApplication.sharedApplication.setStatusBarHidden(false, animated:false)
    end)

    true
  end
  
  def launch_image_name
    case Device.screen.height_for_orientation(:portrait)
    when 480
      # iPhone 3.5 inch 320 x 480px
      return 'Default.png'
    when 960
      # iPhone 3.5 inch retina 640 x 960px
      return 'Default@2x.png'
    when 1136
      # iPhone 4 inch retina 640 x 1136px
      return 'Default-568h@2x.png'
    when 1024
      # iPad / iPad Mini 1024 × 768
      return 'Default-1024h.png'
    when 1024
      # iPad retina 2048 × 1536
      return 'Default-1024h@2x.png'
    end
  end
end