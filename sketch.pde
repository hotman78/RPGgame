import android.view.*;
import processing.event.TouchEvent.*;
import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
public Stage stage;
//public ObjectManager o;
//public Obj obj;
//public Player player;
//public GuiSetter g;
public Event playerEvent;
public EventManager e;
public GestureDetector gestureDetector;
public PApplet pApplet=this;
public boolean pMousePressed=false;
public boolean mouseReleased=false;
public boolean mouseClicked=false;
public float startX=0,startY=0;
void onResume(){
  super.onResume();
  setUI();
}
void setup(){
  textSize(30);
  //g=new GuiSetter();
  e=new EventManager();
  stage=new Stage();
  //o=new ObjectManager();
  e.addEvent("firstVillage/npc.lua",1,1);
  playerEvent=e.addEvent("global/player.lua",2,2);
  Activity act = getActivity();
  Context con = act.getApplicationContext();
  TouchManager tm=new TouchManager();
  Handler mHandler = new Handler(Looper.getMainLooper());
  gestureDetector =new GestureDetector(con, tm, mHandler);
}
void draw(){
  mouseReleased=!mousePressed&&pMousePressed;
  mouseClicked=mousePressed&&!pMousePressed;
  if(mouseClicked){
    startX=mouseX;
    startY=mouseY;
  }
  touches = touchesList.toArray(new Pointer[touchesList.size()]);
  for(Pointer t:touches){
    ellipse(t.x,t.y,10,10);
  }
  background(0);
  stage.draw();
  //o.draw();
  //g.draw();
  e.draw();
  textSize(60);
  text(frameRate,0,60);
  noFill();
  for(Pointer t:touches)ellipse(t.x,t.y,100,100);
  synchronized (touchesList) {
    for(Pointer t:touchesList){
      if(t.dead)touchesList.remove(t);
    }
  }
  pMousePressed=mousePressed;
}
void mouseReleased(){
  e.mouseReleased();
}
void setUI() {
  runOnUiThread(new Runnable() { 
    public void run() { 
      View v = getSurface().getRootView();
      v.setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE);
    }
  });
}