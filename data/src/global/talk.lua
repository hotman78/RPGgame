TalkWindow ={}
function TalkWindow:new(_x,_y)
  local obj={}
  TalkWindow.super=Character:new(_x,_y)
  obj.x=_x
  obj.y=_y
  setmetatable(TalkWindow,{__index=Character})
  setmetatable(obj,{__index=TalkWindow})
  obj:handleSetup()
  return obj
end

function TalkWindow :setup()
  self.canResume=false
  self.X=0
  self.Y=p.height-500
  self.width=p.width
  self.height=500
  self.textSize=100
end
function TalkWindow :draw()
  p:fill(0,0,255,100)
  p:strokeJoin(p.ROUND)
  p:strokeWeight(10)
  p:stroke(100)
  p:rect(self.X+10,self.Y+10,self.width-20,self.height-20)
  p:textSize(self.textSize)
  p:fill(255)
  if self.text then
    p:text(self.text,self.X+20,self.Y+20,self.width-20,self.height-20)
  end
end

function TalkWindow:mouseReleased()
  if self.canResume then
    self.dead=true
    coroutine.resume(self.coro)
	 else self.canResume=true
	 end
end

function TalkWindow:setCoroutine(coro)
  self.coro=coro
end

function TalkWindow:setText(text)
  self.text=text
end