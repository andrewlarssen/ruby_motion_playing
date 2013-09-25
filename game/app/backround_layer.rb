class BackgroundLayer < CCLayer

  def init

    if super

      background_sprite = CCSprite.spriteWithFile('sky.png')

      # We need to get the screen size for positioning the sprite
      screen_size = CCDirector.sharedDirector.winSize

      # Like the CALayers the position is set in reference to the center
      # of the label, in this case we want the sprite to be in the middle
      # of the screen
      background_sprite.position = CGPointMake(screen_size.width / 2, screen_size.height / 2)

      # Add the sprite to the Layer
      self.addChild(background_sprite)
    end

    self
  end

end