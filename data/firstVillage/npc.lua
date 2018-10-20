Character={}
function Character:new(_x,_y)
  local obj={}
  obj.x=_x
  obj.y=_y
  	obj.px=128*obj.x+64
  	obj.py=128*obj.y+64
  return setmetatable(obj, {__index = Character})
end
function Character:setup()
  self.movingDelay=0
  self.angle=1
end
function Character:talkEvent()
  
end
function Character:draw()
  print("b")
  if self.movingDelay>0 then
    self.px=self.px+Direction[self.angle][1]*16
    self.py=self.py+Direction[self.angle][2]*16
    self.movingDelay=self.movingDelay-1
  end
  p:ellipse(self.px,self.py,128,128)
end

function Character:move(angle)
  if not Direction[angle] or self.movingDelay>0 then
    return
  end
  self.angle=angle
  self.movingDelay=8
  self.x=self.x+Direction[angle][1]
  self.y=self.y+Direction[angle][2]
end