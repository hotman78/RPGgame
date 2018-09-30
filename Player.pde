class Player extends Obj{
  int x,y,px,py;
  float sx,sy,cx,cy,angle;
   Player(int x,int y){
    super(x,y);
    //g.addButton(width/3,height-width,width/3,width/3,width/3,"上",new Move(1)).isContinuous();
    //g.addButton(0,height-width+width/3,width/3,width/3,width/3,"左",new Move(2)).isContinuous();
    //g.addButton(width/3*2,height-width+width/3,width/3,width/3,width/3,"右",new Move(3)).isContinuous();
    //g.addButton(width/3,height-width+width/3,width/3,width/3,width/3,"",new Talk());
    //g.addButton(width/3,height-width+width/3*2,width/3,width/3,width/3,"下",new Move(4)).isContinuous();
  }
  void draw(){
    super.draw();
    control();
  }
  void control(){
    if(mouseReleased&&dist(0,0,sx,sy)<50&&o.exist(fx(),fy())!=null){
      o.exist(fx(),fy()).talk();
    }
    if(isTalking)return;
    if(!pMousePressed){
      sx=0;
      sy=0;
      cx=mouseX;
      cy=mouseY;
    }
    strokeWeight(50);
    line(cx,cy,cx+sx,cy+sy);
    sx+=mouseX-pmouseX;
    sy+=mouseY-pmouseY;
    sx=constrain(sx,-100,100);
    sy=constrain(sy,-100,100);
    if(dist(0,0,sx,sy)<50)return;
    angle=atan2(sy,sx);
    if(-PI/4<=angle&&angle<PI/4)move(3);
    if(PI/4<=angle&&angle<PI*3/4)move(4);
    if(PI*3/4<=angle||angle<-PI*3/4)move(2);
    if(-PI*3/4<=angle&&angle<-PI/4)move(1);
  }
}