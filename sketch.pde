import android.view.*;
Stage stage;
ObjectManager o;
Obj obj;
Player player;
GuiSetter g;
EventManager e;
PImage grass;
boolean pMousePressed=false;
boolean mouseReleased=false;
void setup(){
  setUI();
  textSize(30);
  grass =loadImage("forest.jpeg");
  stage=new Stage();
  g=new GuiSetter();
  o=new ObjectManager();
  e=new EventManager();
  o.addObject(1,1);
  player=o.addPlayer(1,1);
  
}
void draw(){
  mouseReleased=!mousePressed&&pMousePressed;
  background(0);
  o.draw();
  g.draw();
  e.draw();
  textSize(60);
  text(frameRate,0,60);
  pMousePressed=mousePressed;
}

void setUI() {
  runOnUiThread(new Runnable() { 
    public void run() { 
  View v = getSurface().getRootView();
  v.setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE);
  }
  });
}