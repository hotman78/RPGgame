function draw()
  playerMove1()
end

function mouseReleased()
  if p:dist(p.mouseX,p.mouseY,p.startX,p.startY)<100 then
    e:handleTalkEvent(fx(),fy())
  end
end