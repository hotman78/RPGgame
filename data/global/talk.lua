
function setup()
  x=0
  y=p.height-500
  width=p.width
  height=500
  textSize=100
end 
function draw()
  p:fill(0,0,255,100)
  p:strokeJoin(ROUND)
  p:strokeWeight(10)
  p:stroke(100)
  p:rect(x+10,y+10,width-20,height-20)
  p:textSize(textSize)
  p:fill(255)
  if text then
    p:text(text,x+20,y+20,width-20,height-20)
  end
end

function mouseReleased()
  kill()
	 coroutine.resume(coro)
end