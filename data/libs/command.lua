function talk(text)
  event=addEvent("global/talk.lua")
  event:set("coro",coroutine.running())
  event:set("text",text)
  coroutine.yield()
end
