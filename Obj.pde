class Obj{
  int px,py,x,y,scale,isMoving,nextMoveDelay,direction;
  String[] code;
  boolean canMove=true;
  boolean isTalking=false;
  Obj(int x,int y){
    this.x=x;
    this.y=y;
    px=x*128+64;
    py=y*128+64;
    scale=16;
    code=loadStrings("object/npc.text"); 
  }
  void draw(){
    x=constrain(x,0,width/128-1);
    y=constrain(y,0,height/128-1);
    px=constrain(px,64,width-64);
    py=constrain(py,64,height-64);
    ellipse(px,py,128,128);
    switch(isMoving){
      case 1:py-=scale;break;
      case 2:px-=scale;break;
      case 3:px+=scale;break;
      case 4:py+=scale;break;
    }
    nextMoveDelay--;
    if(nextMoveDelay==0)isMoving=0;
  }
  void move(int f){
    if(!canMove)return;
    if(isMoving==0){
      direction=f;
      if(o.exist(fx(),fy())==null){
        isMoving=f;
        nextMoveDelay=8;
        switch(f){
          case 1:y--;break;
          case 2:x--;break;
          case 3:x++;break;
          case 4:y++;break;
        }
      }
    }
  }
  int fx(){
    switch(direction){
      case 2:return x-1;
      case 3:return x+1;
      default:return x;
    }
  }
  int fy(){
    switch(direction){
      case 1:return y-1;
      case 4:return y+1;
      default :return y;
    }
  }
  void stop(){
    canMove=false;
  }
  void start(){
    canMove=true;
  }
  void talk(){
    if(player.isTalking)return;
    player.isTalking=true;
    e.addEvent(code);
  }
}

