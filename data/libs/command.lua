function talk(text)
  event=addEvent("global/talk.lua")
  event:set("coro",coroutine.running())
  event:set("text",text)
  coroutine.yield()
end
function addButton(X,Y,width,height,text)
  event=addEvent("global/button.lua")
  event:set("X",X)
  event:set("Y",Y)
  event:set("width",width)
  event:set("height",height)
  event:set("text",text)
  return event
end

function playerMove1()
  if (not p.mousePressed) then 
    return 
  end
  if p.mouseClicked then
      sx=0
      sy=0
      cx=p.mouseX
      cy=p.mouseY
  end
  p:strokeWeight(50)
  p:line(cx,cy,cx+sx,cy+sy)
  sx=sx+p.mouseX-p.pmouseX
  sy=sy+p.mouseY-p.pmouseY
  if p:dist(0,0,sx,sy)>50 then
    sx=sx*100/p:dist(0,0,sx,sy)
    sy=sy*100/p:dist(0,0,sx,sy)
    local angle = math.floor((p:atan2(sy,sx)+math.pi/8)*4/math.pi)+1
    if angle<1 then
      angle=angle+8
    end
    move(angle)
  end
end

function playerMove2()

end
function fx()
  return e.fx
end
function fy()
  return e.fy
end