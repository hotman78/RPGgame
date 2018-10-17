import android.view.*;
Stage stage;
ObjectManager o;
Obj obj;
Player player;
GuiSetter g;
EventManager e;
PApplet pApplet=this;
PImage grass;
boolean pMousePressed=false;
boolean mouseReleased=false;
boolean mouseClicked=false;
float startX,startY;
void onResume(){
  super.onResume();
  setUI();
}
void setup(){
  textSize(30);
  g=new GuiSetter();
  e=new EventManager();
  stage=new Stage();
  o=new ObjectManager();
  o.addObject(1,1,"firstVillage/npc.txt");
  player=o.addPlayer(2,2,"global/player.lua");
  
}
void draw(){
  mouseReleased=!mousePressed&&pMousePressed;
  mouseClicked=mousePressed&&!pMousePressed;
  if(mouseClicked){
    startX=mouseX;
    startY=mouseY;
  }
  background(0);
  text(player.px,0,30);
  stage.draw();
  o.draw();
  g.draw();
  e.draw();
  textSize(60);
  text(frameRate,0,60);
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