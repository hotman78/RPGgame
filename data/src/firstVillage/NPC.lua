NPC={}
function NPC:new(_x,_y)
  local obj={}
  NPC.super=Character:new(_x,_y)
  obj.x=_x
  obj.y=_y
  setmetatable(NPC,{__index=Character})
  setmetatable(obj,{__index=NPC})
  obj:handleSetup()
  return obj
end

function NPC:setup()
  
end

function NPC:draw()
  
end

function NPC:talkEvent()
  self:talk("hello")
  self:talk("buy")
end
