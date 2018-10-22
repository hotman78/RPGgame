Character={}
function Character:new(_x,_y)
  local obj={}
  obj.x=_x
  obj.y=_y
  setmetatable(obj, {__index = Character})
  obj:handleSetup()
  return obj
end
function Character:handleSetup()
  	self.px=128*self.x+64
  	self.py=128*self.y+64
  self.movingDelay=0
  self.angle=1
  self.dead=false
  local image=p:loadImage("wolfarl.png")
  self.images={}
  for i=0,5 do for j=0,3 do
    self.images[i+j*6+1]=image:get(i*image.width/6,j*image.height/4,image.width/6,image.height/4)
  end end
  self:setup()
end
function Character:setup()
  
end
function Character:talkEvent()
  
end
function Character:handleDraw()
  if self.movingDelay>0 then
    self.px=self.px+Direction[self.angle][1]*16
    self.py=self.py+Direction[self.angle][2]*16
    self.movingDelay=self.movingDelay-1
  end
  p:imageMode(p.CENTER)
  local image=self.images[Direction[self.angle][3]*3-2]
  p:image(image,self.px-stage.cameraX,self.py-stage.cameraY,128*image.width/image.height,128)
  self:draw()
end
function Character:draw()

end
function Character:move(angle)
  if not Direction[angle] or self.movingDelay>0 then
    return
  end
  self.angle=angle
  if(canMove(self.x+Direction[angle][1],self.y+Direction[angle][2])) then
    self.movingDelay=8
    self.x=self.x+Direction[angle][1]
    self.y=self.y+Direction[angle][2]
    self.fx=self.x+Direction[angle][1]
    self.fy=self.y+Direction[angle][2]
  end
end
function Character:handleTalk(player)
  local coro=coroutine.wrap(
  function()
    self:talkEvent()
    player.isTalking=false
  end)
  coro()
end
function Character:talkEvent()

end

function Character:talk(text)
 local talkWindow=TalkWindow:new(-1,-1)
 talkWindow:setCoroutine(coroutine.running())
 talkWindow:setText(text)
 addEvent(talkWindow)
 coroutine.yield()
end

function Character:mouseReleased()
 
end