Player={}
function Player:new(_x,_y)
  local obj={}
  Player.super=Character:new(_x,_y)
  obj.x=_x
  obj.y=_y
  setmetatable(Player,{__index=Character})
  setmetatable(obj,{__index=Player})
  obj:handleSetup()
  return obj
end

function Player:setup()
  self.isTalking=false
end

function Player:draw()
  self:playerMove()
end

function Player:mouseReleased()
  if p:dist(p.mouseX,p.mouseY,p.startX,p.startY)<50 and exist(self.fx,self.fy) and not self.isTalking then
    self.isTalking=true
    exist(self.fx,self.fy):handleTalk(self)
  end
end

function Player:playerMove()
  if (not p.mousePressed) then 
    return 
  end
  if p.mouseClicked then
      self.sx=0
      self.sy=0
      self.cx=p.mouseX
      self.cy=p.mouseY
  end
  local sx=self.sx
  local sy=self.sy
  local cx=self.cx
  local cy=self.cy
  p:strokeWeight(50)
  p:line(cx,cy,cx+sx,cy+sy)
  sx=sx+p.mouseX-p.pmouseX
  sy=sy+p.mouseY-p.pmouseY
  if p:dist(0,0,sx,sy)>50 then
    sx=sx*100/p:dist(0,0,sx,sy)
    sy=sy*100/p:dist(0,0,sx,sy)
    local angle = math.floor((p:atan2(sy,sx)+math.pi/8)*4/math.pi)+2
    if angle<2 then
      angle=angle+8
    end
    self:move(angle)
  end
  self.sx=sx
  self.sy=sy
  self.cx=cx
  self.cy=cy
end