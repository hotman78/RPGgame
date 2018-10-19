class Stage{
  PImage mapImage=loadImage("map.png");
  PImage disp;
  int cameraX,cameraY;
  void draw(){
    cameraX=constrain((int)playerEvent.px-width/2,0,mapImage.width*8-width);
    cameraY=constrain((int)playerEvent.py-height/2,0,mapImage.height*8-height);
    imageMode(CORNER);
    image(mapImage.get(cameraX/8,cameraY/8,width/8,height/8),0,0,width,height);
  }
}