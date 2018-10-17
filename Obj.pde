class Obj{
  int px,py,x,y,scale,isMoving,nextMoveDelay,direction;
  String[] code;
  boolean canMove=true;
  boolean isTalking=false;
  Event event;
  Obj(int x,int y,String eventPath){
    this.x=x;
    this.y=y;
    px=x*128+64;
    py=y*128+64;
    scale=16;
    event=e.addEvent(eventPath,x,y);
    event.setObj(this);
  }
  void draw(){
    /*x=constrain(x,0,stage.mapImage.width/16-1);
    y=constrain(y,0,stage.mapImage.height/16-1);
    px=constrain(px,64,stage.mapImage.width*8-64);
    py=constrain(py,64,stage.mapImage.height*8-64);
    ellipse(px-stage.cameraX,py-stage.cameraY,128,128);
    switch(isMoving){
      case 1:py-=scale;break;
      case 2:px-=scale;break;
      case 3:px+=scale;break;
      case 4:py+=scale;break;
    }
    nextMoveDelay--;
    if(nextMoveDelay==0)isMoving=0;*/
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
    if(player.isTalking||player.talkingWait!=0)return;
    player.isTalking=true;
    event.doFunction("talkEvent");
  }
}

