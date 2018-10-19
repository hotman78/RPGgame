import org.luaj.vm2.*; 	
import org.luaj.vm2.lib.jse.*;
import org.luaj.vm2.lib.*;
class Event {
  public Globals globals;
  public float x,y,px,py,fx,fy,v;
  public Direction facingDirection=Direction.DOWN;
  public Direction movingDirection=Direction.NONE;
  public int movingDelay,talkingWait=0,chara;
  public boolean isTalking=false;
  public boolean dead=false, isMoving=false;
  public PImage[] charaChips=new PImage[24];
  Event(String path, float x, float y) {
    v=16.0;
    PImage charaChip=loadImage("Wolfarl.png");
    for(int i=0;i<6;i++)for(int j=0;j<4;j++){
      charaChips[j*6+i]=charaChip.get(i*charaChip.width/6,j*charaChip.height/4,charaChip.width/6,charaChip.height/4);
    }
    globals = JsePlatform.standardGlobals();
    globals.set("x", x);
    globals.set("y", y);
    globals.set("px", x*128+64);
    globals.set("py", y*128+64);
    globals.set("exit", new Exit());
    globals.set("addEvent", new AddEvent());
    globals.set("kill", new Kill());
    globals.set("move", new Move());
    globals.set("p", CoerceJavaToLua.coerce(pApplet));
    globals.set("e", CoerceJavaToLua.coerce(this));
    globals.load(new JseBaseLib());
    globals.load(new PackageLib());
    globals.load(new MathLib());
    globals.load(new DebugLib());
    String[] command=loadStrings("libs/command.lua");
    String[] codes=loadStrings(path);
    globals.load(join(command, "\n")).call();
    globals.load(join(codes, "\n")).call();
    doFunction("setup");
  }
  void draw() {
    if(talkingWait>0)talkingWait--;
    x=globals.get("x").tofloat();
    y=globals.get("y").tofloat();
    px=globals.get("px").tofloat();
    py=globals.get("py").tofloat();
    if (movingDirection!=Direction.NONE) {
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
    imageMode(CENTER);
    int id=0;
    switch(facingDirection){
      case DOWN:id=0;break;
      case LEFT:id=2;break;
      case RIGHT:id=4;break;
      case UP:id=6;break;
      case LEFTDOWN:id=1;break;
      case RIGHTDOWN:id=3;break;
      case LEFTUP:id=5;break;
      case RIGHTUP:id=7;break;
    }
    if(frameCount%10==0)chara++;
    if(frameCount%10==0&&chara==3)chara=0;
    image(charaChips[id*3+chara],px-stage.cameraX, py-stage.cameraY,128*charaChips[id*3+chara].width/charaChips[chara].height,128);
    globals.set("x",x);
    globals.set("y",y);
    globals.set("px",px);
    globals.set("py",py);
  }
  void set(String name,LuaValue data){
    globals.set(name,data);
  }
  void set(String name,String data){
    globals.set(name,data);
  }
  void handleTalkEvent(float x,float y){
    Event event=e.exist(x,y);
    if(event==null||event.isTalking||event.talkingWait!=0)return;
    event.isTalking=true;
    if (event.globals.get("talkEvent").isnil())return;
    event.globals.load("co=coroutine.create(function()  talkEvent()  exit()  end)").call();
    event.globals.load("coroutine.resume(co)").call();
  }
  void move(Direction d) {
    x=globals.get("x").tofloat();
    y=globals.get("y").tofloat();
    px=globals.get("px").tofloat();
    py=globals.get("py").tofloat();
    if(movingDelay!=0)return;
    if(d==Direction.NONE)return;
    facingDirection=d;
    fx=x+d.get().x;
    fy=y+d.get().y;
    if (e.exist(x+d.get().x, y+d.get().y)!=null)return;
    movingDirection=d;
    x+=d.get().x;
    y+=d.get().y;
    movingDelay=8;
    globals.set("x",x);
    globals.set("y",y);
    globals.set("px",px);
    globals.set("py",py);
  }
  void doFunction(String function) {
    if (globals.get(function).isnil())return;
    globals.load("co=coroutine.create("+function+")").call();
    globals.load("coroutine.resume(co)").call();
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
      if(value.isint()){
        d=Direction.values()[value.toint()];
      }else if (value.isstring()){
        d =Direction.valueOf(value.toString());
      }
      if(d!=null)move(d);
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
      isTalking=false;
      talkingWait=5;
      return LuaValue.valueOf(true);
    }
  }
}
class EventManager {
 
  ArrayList<Event> events;
  EventManager() {
    events=new ArrayList<Event>();
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
  void onDown(){
   for (int i=0; i<events.size(); i++) {
      events.get(i).doFunction("onDown");
    }
  }
}