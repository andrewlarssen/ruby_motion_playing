class MoleLayer < CCLayer

  def init
    
    @game_state = GameState.instance
    @game_state.score = 0
    @touch_enabled = true

    if super
      # We need to get the screen size for positioning the sprite
      screen_size = CCDirector.sharedDirector.winSize
      @grass = CCSprite.spriteWithFile('Grass.png')

      # Like the CALayers the position is set in reference to the center
      # of the label, in this case we want the sprite to be in the middle
      # of the screen
      @grass.position = CGPointMake(screen_size.width / 2, screen_size.height / 12)

      # Add the sprite to the Layer
      self.addChild(@grass, z:999)
      
      @good_moles = []
      @bad_moles  = []
      
      3.times do |i|
        # Create a new sprite instance for drawing our spaceship
        good_mole = CCSprite.spriteWithFile('charlotte.png')
        
        # Add moles at intervals to screen
        good_mole.position = CGPointMake((i+1) * screen_size.width / 4, -10)
        
        # Add the sprite to the Layer
        self.addChild(good_mole, z: 0)
        
        @good_moles << good_mole
        
        # Create a new sprite instance for drawing our spaceship
        bad_mole = CCSprite.spriteWithFile('monster.png')
        
        # Add moles at intervals to screen
        bad_mole.position = CGPointMake((i+1) * screen_size.width / 4, -10)
        
        # Add the sprite to the Layer
        self.addChild(bad_mole, z: 0)
        
        @bad_moles << bad_mole
      end
      
      @all_moles  = @good_moles + @bad_moles
      
      self.isTouchEnabled = true
      
      @score_label = CCLabelTTF.labelWithString("Score: #{@game_state.score}", fontName:"Verdana",fontSize: 14)
      @score_label.position = CGPointMake( 9*screen_size.width / 10, 9*screen_size.height / 10)
      self.addChild(@score_label, z:999)
      
      @time = Config::SPEEDS[@game_state.speed][:duration]
      @time_label = CCLabelTTF.labelWithString("Time: #{@time}", fontName:"Verdana",fontSize: 14)
      @time_label.position = CGPointMake( screen_size.width / 10, 9*screen_size.height / 10)
      self.addChild(@time_label, z:999)
      
      schedule :tryPopMoles
      schedule :update_time, interval: 1
    end

    self
  end

  def tryPopMoles
    random = Random.new
    @all_moles.shuffle.each do |mole|

      next unless (random.rand(1..100) % 3 == 0)
      next if @all_moles.any? { |m| m.numberOfRunningActions == 1 }
      popMole(mole)
    end
  end

  def popMole(mole)
    @touch_enabled = true
    moveUp = CCMoveBy.actionWithDuration(Config::SPEEDS[@game_state.speed][:move], position: CGPointMake(0, mole.contentSize.height * 0.9)); # 1
    easeMoveUp = CCEaseInOut.actionWithAction(moveUp, rate: 3.0); #2
    easeMoveDown = easeMoveUp.reverse # 3
    delay = CCDelayTime.actionWithDuration(Config::SPEEDS[@game_state.speed][:delay]) # 4
    mole.runAction(CCSequence.actionsWithArray([easeMoveUp, delay, easeMoveDown])); # 5
  end

  def ccTouchesBegan(touches, withEvent:event)
    return unless @touch_enabled
    touch = touches.anyObject

    touch_location = self.convertTouchToNodeSpace(touch)
    @good_moles.each do |mole|
      next unless CGRectContainsPoint(mole.boundingBox, touch_location) and !CGRectContainsPoint(@grass.boundingBox, touch_location)
      @touch_enabled = false
      
      @game_state.score += 10
      SimpleAudioEngine.sharedEngine.playEffect "slap.wav" 
    end
    
    @bad_moles.each do |mole|
      next unless CGRectContainsPoint(mole.boundingBox, touch_location) and !CGRectContainsPoint(@grass.boundingBox, touch_location)
      @touch_enabled = false
      
      @game_state.score -= 50
      SimpleAudioEngine.sharedEngine.playEffect "slap.wav" 
    end
    
    @score_label.setString("Score: #{@game_state.score}")
  end

  def update_time
    @time -= 1
    @time_label.setString("Time: #{@time}")
    end_game if @time == 0
  end
  
  def end_game
    unscheduleAllSelectors
    CCDirector.sharedDirector.replaceScene(FinishedScene.node)
  end
end
