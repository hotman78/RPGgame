function draw()
print("a")
  if (not p.mousePressed) then return end
  print("b")
  local dx=p.mouseX-p.startX
  local dy=p.mouseY-p.startY
  print("c")
  p:line(p.mouseX,p.mouseY,p.startX,p.startY)
  print("d")
  local angle = math.floor(atan2(dy,dx)*4/math.pi)
  move(angle)
end