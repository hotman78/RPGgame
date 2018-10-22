Stage={}
function Stage:new(_x,_y)
  local obj={}
  Stage.super=Character:new(_x,_y)
  obj.x=_x
  obj.y=_y
  setmetatable(Stage,{__index=Character})
  setmetatable(obj,{__index=Stage})
  obj:handleSetup()
  return obj
end

function Stage:setup()
  self.mapImage=p:loadImage("map.png")
  self.cameraX=0
  self.cameraY=0
end

function Stage:draw()
    self.cameraX=p:constrain(player.px-p.width/2,0,self.mapImage.width*8-p.width);
    self.cameraY=p:constrain(player.py-p.height/2,0,self.mapImage.height*8-p.height);
    p:imageMode(p.CORNER);
    p:image(self.mapImage:get(self.cameraX/8,self.cameraY/8,p.width/8,p.height/8),0,0,p.width,p.height);
end