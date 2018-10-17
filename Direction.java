import processing.core.PVector;
public enum Direction {
  NONE(null),
  RIGHT(new PVector(1,0)),
  RIGHTUP(new PVector(1,1)),
  UP(new PVector(0,1)),
  LEFTUP(new PVector(-1,1)),
  LEFT(new PVector(-1,0)),
  LEFTDOWN(new PVector(-1,-1)),
  DOWN(new PVector(0,-1)),
  RIGHTDOWN(new PVector(1,-1));
  
  private PVector direction;
  private Direction(PVector direction) {
    this.direction = direction;
  }
  public PVector get(){
    return this.direction;
  }
}