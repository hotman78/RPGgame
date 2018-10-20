function setup()
  events={}
  events[0]=Player:new(1,1)
  for key,event in pairs(events) do
    event:setup()
  end
end
function draw()
  for key,event in pairs(events) do
    event:draw()
  end
end