class GUI {
  int x,y,sizeX,sizeY;
  int textSize=100;
  String text="";
  Event event;
  PImage window;
  PImage[][] win;
  boolean continuous=false;
  boolean isVisible=true;
  boolean dead=false;
  GUI(int x,int y,int sizeX,int sizeY,String text,Event event){
    this.x=x;
    this.y=y;
    this.sizeX=sizeX;
    this.sizeY=sizeY;
    this.text=text;
    this.event=event;
  }
  void draw(){
    if(!isVisible)return;
    fill(0,0,255,100);
    strokeJoin(ROUND);
    strokeWeight(10);
    stroke(100);
    rect(x+10,y+10,sizeX-20,sizeY-20);
    textSize(textSize);
    //textAlign(CENTER);
    fill(255);
    text(text,x+20,y+20,sizeX-20,sizeY-20);
    action();
  }
  void action(){
    if(!mouseReleased)return;
    if(x<mouseX&&mouseX<x+sizeX&&y<mouseY&&mouseY<y+sizeY){
      //if(event.prohibitResuming)return;
      //event.selected=text;
      event.globals.load("coroutine.resume(co)").call();
    }
  }
  GUI setText(String text){
    this.text=text;
    return this;
  }
  GUI isContinuous(){
    continuous=true;
    return this;
  }
  GUI setVisible(boolean isVisible){
    this.isVisible=isVisible;
    return this;
  }
  GUI setTextSize(int textSize){
    this.textSize=textSize;
    return this;
  }
  void remove(){
    dead=true;
  }
}

class Button extends GUI{
  Button(int x,int y,int sizeX,int sizeY,String text,Event event){
    super(x,y,sizeX,sizeY,text,event);
  }
}

class TextWindow extends GUI{
  LuaTable options;
  TextWindow(int x,int y,int sizeX,int sizeY,String text){
    super(x,y,sizeX,sizeY,text,null);
  }
  public void action(){}
}
class OptionWindow extends GUI{
  Button[] buttons;
  OptionWindow(int x,int y,int sizeX,int sizeY,Event event){
    super(x,y,sizeX,sizeY,"",event);
    setVisible(false);
  }
  OptionWindow setOptions(LuaTable options){
    buttons=new Button[options.length()];
    for(int i=0;i<options.length();i++){
      buttons[i]=g.addButton(x,y+sizeY*i/options.length(),sizeX,sizeY/options.length(),options.get(i+1).toString(),event);
    }
    return this;
  }
  void remove(){
    super.remove();
    for(Button b:buttons){
      b.remove();
    }
  }
  void action(){}
}