class StartScene < CCScene

 def init

   if super
     @game_state = GameState.instance
     # Create a new instance of a Background Layer
     background_layer = BackgroundLayer.node
     # Add it to the scene
     self.addChild(background_layer, z: -10)
     
     screen_size = CCDirector.sharedDirector.winSize
     
     @banner = CCLabelTTF.labelWithString("Squash Charlotte", fontName:"Verdana",fontSize: 48)
     @banner.position = CGPointMake( screen_size.width / 2, 3 * screen_size.height / 4)
     self.addChild(@banner, z:999)
     
     
     CCMenuItemFont.setFontName "Verdana"
     CCMenuItemFont.setFontSize 32

     item1 = CCMenuItemFont.itemWithString("Play", block: lambda { |a| CCDirector.sharedDirector.replaceScene(GrassScene.node)})
     item2 = CCMenuItemFont.itemWithString("Speed: #{@game_state.speed}", block: lambda { |i| @game_state.speed = Config.next_speed(@game_state.speed) ; i.setString("Speed: #{@game_state.speed}") })
     
     menu = CCMenu.menuWithArray [item1, item2]
     menu.setPosition CGPointMake(screen_size.width / 2, 2 * screen_size.height / 4)
     menu.alignItemsVertically
     
     self.addChild(menu, z:999)
     
     size = CGSizeMake(screen_size.width - 20, 50)
     alignment = 

     @instructions = CCLabelTTF.labelWithString("Squash as many Charlottes as you can, but watch out for monsters...",
        dimensions:CGSizeMake(screen_size.width - 20, 75),
        alignment:KCCTextAlignmentCenter,
        lineBreakMode:KCCLineBreakModeWordWrap,
        fontName:"Verdana",
        fontSize: 24)
        
     #@instructions.anchorPoint = CGPointMake(0.5,0.5);
       
     @instructions.position = CGPointMake( screen_size.width / 2, screen_size.height / 6)
     
     self.addChild(@instructions, z:999)
   end

   self
 end

end