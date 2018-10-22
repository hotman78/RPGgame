function setup()
  image =p:loadImage("map.png")
  events={}
  stage=Stage:new(-1,-1)
  addEvent(stage)
  player=Player:new(2,2)
  addEvent(player)
  addEvent(NPC:new(1,1))
end
function draw()
  p:image(image,0,0)
  for key,event in pairs(events) do
    if(event.dead)then 
      table.remove(events,key)
    else event:handleDraw()
    end
  end
end
function mouseReleased()
  for key,event in pairs(events) do
    event:mouseReleased()
  end
end
function canMove(x,y)
  if(x<0 or stage.mapImage.width/16<x or y<0 or stage.mapImage.height/16-1<y) then
    return false
  end
  if exist(x,y) then
    return false
  end
  return true
end
function exist(x,y)
  for key,event in pairs(events) do
    if event.x==x and event.y==y then
      return event
    end
  end
  return nil
end

function addEvent(event)
  events[#events+1]=event
end