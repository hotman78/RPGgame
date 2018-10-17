class Player extends Obj{
  float sx,sy,cx,cy,angle;
  int talkingWait;
   Player(int x,int y,String eventPath){
    super(x,y,eventPath);
  }
  void draw(){
    if(talkingWait!=0)talkingWait--;
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