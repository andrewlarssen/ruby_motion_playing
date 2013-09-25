class GrassScene < CCScene

 def init

   if super
     # Create a new instance of a Background Layer
     background_layer = BackgroundLayer.node
     # Add it to the scene
     self.addChild(background_layer, z: -10)
     # Create a new instance of a Game Play Layer
     mole_layer = MoleLayer.node

     # Add it to the scene
     self.addChild(mole_layer)
   end

   self
 end

end