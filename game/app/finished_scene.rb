class FinishedScene < CCScene

 def init

   if super
     @game_state = GameState.instance
     
     defaults = NSUserDefaults.standardUserDefaults
     
     high_score = defaults["high_score_#{@game_state.speed}"] || 0
     
     if @game_state.score > high_score
       score_message = "You scored: #{@game_state.score}. That's a new high score!"
       high_score = defaults["high_score_#{@game_state.speed}"] = @game_state.score
     else
       score_message = "You scored: #{@game_state.score}. High score: #{high_score}"
     end
     
     
     # Create a new instance of a Background Layer
     background_layer = BackgroundLayer.node
     # Add it to the scene
     self.addChild(background_layer, z: -10)
     
     screen_size = CCDirector.sharedDirector.winSize
     
     @banner = CCLabelTTF.labelWithString("GAME OVER", fontName:"Verdana",fontSize: 48)
     @banner.position = CGPointMake( screen_size.width / 2, 3 * screen_size.height / 4)
     self.addChild(@banner, z:999)
     
     @score_label = CCLabelTTF.labelWithString(score_message,
         dimensions:CGSizeMake(screen_size.width - 20, 75),
         alignment:KCCTextAlignmentCenter,
         lineBreakMode:KCCLineBreakModeWordWrap,
         fontName:"Verdana",
         fontSize: 18)
     @score_label.anchorPoint = CGPointMake(0.5,0.5);
     @score_label.position = CGPointMake( screen_size.width / 2, 2 * screen_size.height / 4)
     self.addChild(@score_label, z:999)
     
     
     
     
     
     CCMenuItemFont.setFontName "Verdana"
     CCMenuItemFont.setFontSize 32

     item1 = CCMenuItemFont.itemWithString("Again", block: lambda { |a| CCDirector.sharedDirector.replaceScene(StartScene.node)})
     
     menu = CCMenu.menuWithArray [item1]
     menu.setPosition CGPointMake(screen_size.width / 2, screen_size.height / 4)
     menu.alignItemsVertically
     
     self.addChild(menu, z:999)
   end

   self
 end

end