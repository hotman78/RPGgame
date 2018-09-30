import org.luaj.vm2.*; 	
import org.luaj.vm2.lib.jse.*;
import org.luaj.vm2.lib.*;
class Event {
  String[] codes;
  String selected="";
  Globals globals;
  LuaThread co;
  LuaValue chunk;
  boolean isSuspended=false;
  boolean prohibitResuming=false;
  boolean dead=false;
  Event(String[] codes) {
    this.codes=codes;
    globals = JsePlatform.standardGlobals();
    globals.set("talk",new Talk());
    globals.set("exit",new Exit());
    globals.set("choice",new Choice());
    globals.load("function test()\n"+join(codes,"\n")+"\n exit() \n end").call();
    globals.load("co=coroutine.create(test)").call();
    globals.load("coroutine.resume(co)").call();
  }
  void resume(){
    if(isSuspended&&mouseReleased&&!prohibitResuming){
      e.talkWindow.setVisible(false);
      isSuspended=false;
      globals.load("coroutine.resume(co)").call();
    }
    prohibitResuming=false;
  }
  class Exit extends ZeroArgFunction{
    public LuaValue call(){
      player.isTalking=false;
      dead=true;
      return LuaValue.valueOf(true);
    }
  }
  class Talk extends OneArgFunction{
    public LuaValue call(LuaValue arg){
      String text=arg.toString();
      e.talkWindow.setVisible(true);
      e.talkWindow.setText(text);
      isSuspended=true;
      prohibitResuming=true;
      globals.load("coroutine.yield()").call();
      return LuaValue.valueOf(true);
    }
  }
  class Choice extends OneArgFunction{
    public LuaValue call(LuaValue arg){
      LuaTable options=arg.checktable();
      OptionWindow w=g.addOptionWindow(0,height-400,width,400,options,Event.this);
      prohibitResuming=true;
      globals.load("coroutine.yield()").call();
      w.remove();
      return LuaValue.valueOf(selected);
    }
  }
}
class EventManager {
  ArrayList<Event> events;
  TextWindow talkWindow;
  HashMap<String, String> var=new HashMap<String, String>();
  EventManager() {
    events=new ArrayList<Event>();
    talkWindow=g.addTextWindow(0, height-500, width, 500, "");
    talkWindow.setVisible(false);
  }
  void addEvent(String[] codes) {
    events.add(new Event(codes));
  }
  void draw() {
    for (int i=0; i<events.size(); i++) {
      if(events.get(i).dead)events.remove(i);
      else events.get(i).resume();
    }
  }
}