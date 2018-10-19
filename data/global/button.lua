function setup()
  canResume=false
  textSize=100
end
function draw()
  p:fill(0,0,255,100)
  p:strokeJoin(ROUND)
  p:strokeWeight(10)
  p:stroke(100)
  p:rect(X+10,Y+10,width-20,height-20)
  p:textSize(textSize)
  p:fill(255)
  if text then
    p:text(text,X+20,Y+20,width-20,height-20)
  end
end

function addFunction(func)
  self.func=func
end

function mouseReleased()
  if X<p.mouseX and p.mouseX<X+width and Y<p.mouseY and p.mouseY<Y+height then
  func()
  end
end