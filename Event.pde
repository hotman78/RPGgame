import org.luaj.vm2.*; 	
import org.luaj.vm2.lib.jse.*;
import org.luaj.vm2.lib.*;
class Event {
  float x, y, px, py, v;
  Direction facingDirection=Direction.DOWN;
  Direction movingDirection=Direction.NONE;
  int movingDelay;
  Globals globals;
  Obj object;
  boolean dead=false, isMoving=false;
  Event(String path, float x, float y) {
    this.x=x;
    this.y=y;
    px=x*128+64;
    py=y*128+64;
    v=16;
    globals = JsePlatform.standardGlobals();
    globals.set("exit", new Exit());
    globals.set("addEvent", new AddEvent());
    globals.set("kill", new Kill());
    globals.set("move", new Move());
    globals.set("p", CoerceJavaToLua.coerce(pApplet));
    globals.set("g", CoerceJavaToLua.coerce(g));
    globals.set("o", CoerceJavaToLua.coerce(o));
    globals.load(new JseBaseLib());
    globals.load(new PackageLib());
    globals.load(new DebugLib());
    String[] command=loadStrings("libs/command.lua");
    String[] codes=loadStrings(path);
    globals.load(join(command, "\n")).call();
    globals.load(join(codes, "\n")).call();
    doFunction("setup");
  }
  void draw() {
    if (movingDirection.get()!=null) {
      if (movingDelay==0) {
        movingDirection=Direction.NONE;
        return;
      } else {
        px+=movingDirection.get().x*v;
        py+=movingDirection.get().y*v;
        movingDelay--;
      }
    }
    x=constrain(x, 0, stage.mapImage.width/16-1);
    y=constrain(y, 0, stage.mapImage.height/16-1);
    px=constrain(px, 64, stage.mapImage.width*8-64);
    py=constrain(py, 64, stage.mapImage.height*8-64);
    ellipse(px-stage.cameraX, py-stage.cameraY, 128, 128);
  }
  void move(Direction d) {
    facingDirection=d;
    if (e.exist(x+d.get().x, y+d.get().y)!=null)return;
    movingDirection=d;
    x=x+d.get().x;
    y=y+d.get().y;
    movingDelay=8;
  }
  void doFunction(String function) {
    if (globals.get(function).isnil())return;
    globals.load("co=coroutine.create("+function+")").call();
    globals.load("coroutine.resume(co)").call();
  }
  LuaValue get(String name) {
    return globals.get(name);
  }
  void set(String name, LuaValue value) {
    globals.set(name, value);
  }
  void set(String name, String value) {
    globals.set(name, value);
  }
  void set(String name, int value) {
    globals.set(name, value);
  }
  void set(String name, float value) {
    globals.set(name, value);
  }
  void setObj(Obj object) {
    this.object=object;
  }
  class AddEvent extends OneArgFunction {
    public LuaValue call(LuaValue value) {
      Event event=e.addEvent(value.toString(), 0, 0);
      return CoerceJavaToLua.coerce(event);
    }
  }
  class Move extends OneArgFunction {
    public LuaValue call(LuaValue value) { 
      Direction d=null;
      if (value.isstring()){
        d =Direction.valueOf(value.toString());
      }else if(value.isint()){
        d=Direction.values()[value.toint()];
      }
      move(d);
      return CoerceJavaToLua.coerce(true);
    }
  }
  class Kill extends OneArgFunction {
    public LuaValue call(LuaValue value) {
      dead=true;
      return CoerceJavaToLua.coerce(true);
    }
  }
  class Exit extends ZeroArgFunction {
    public LuaValue call() {
      player.isTalking=false;
      player.talkingWait=5;
      return LuaValue.valueOf(true);
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
  Event addEvent(String path, float x, float y) {
    Event event=new Event(path, x, y);
    events.add(event);
    return event;
  }
  void draw() {
    for (int i=0; i<events.size(); i++) {
      if (events.get(i).dead)events.remove(i);
      else {
        events.get(i).draw();
        events.get(i).doFunction("draw");
      }
    }
  }
  void mouseReleased() {
    for (int i=0; i<events.size(); i++) {
      events.get(i).doFunction("mouseReleased");
    }
  }
  Event exist(float x, float y) {
    for (int i=0; i<events.size(); i++) {
      if (events.get(i).x==x&&events.get(i).y==y)return events.get(i);
    }
    return null;
  }
}
