Player={}
function Player:new(_x,_y)
  local obj={super=Character:new(_x,_y)}
  obj.x=_x
  obj.y=_y
  	obj.px=128*obj.x+64
  	obj.py=128*obj.y+64
  setmetatable(Player,{__index=Character})
  return setmetatable(obj,{__index=Player})
end

function Player:setup()
  super.setup(self)
end

function Player:draw()
  super.draw(self)
end