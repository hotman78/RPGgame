import android.view.*;
import java.util.ArrayList; 
import java.util.Collections; 
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
List<Pointer> touchesList=new CopyOnWriteArrayList<Pointer>();
Pointer[] touches;
@Override
public boolean surfaceTouchEvent(MotionEvent event) {
  int count=event.getPointerCount();
  int action=event.getAction();
  int actionMasked = action & MotionEvent.ACTION_MASK;
  int idx = (event.getAction() & MotionEvent.ACTION_POINTER_INDEX_MASK) >> MotionEvent.ACTION_POINTER_INDEX_SHIFT;
  boolean down=actionMasked==MotionEvent.ACTION_DOWN||actionMasked==MotionEvent.ACTION_POINTER_DOWN||actionMasked==MotionEvent.ACTION_CANCEL;
  boolean up = actionMasked==MotionEvent.ACTION_UP||actionMasked==MotionEvent.ACTION_POINTER_UP||actionMasked==MotionEvent.ACTION_CANCEL;
  boolean move=actionMasked==MotionEvent.ACTION_MOVE;
  Pointer t=null;
  if(down){
    t=new Pointer();
    t.id=event.getPointerId(idx);
    t.x=event.getX(idx);
    t.y=event.getY(idx);
    t.sx=event.getX(idx);
    t.sy=event.getY(idx);
    t.area=event.getSize(idx);
    t.pressure=event.getPressure(idx);
    touchesList.add(t);
  }
  if(move){
    for(Pointer touch:touches){
      int i=event.findPointerIndex(touch.id);
      if(i==-1)continue;
      touch.id=event.getPointerId(i);
      touch.x=event.getX(i);
      touch.y=event.getY(i);
      touch.area=event.getSize(i);
      touch.pressure=event.getPressure(i);
    }
  }
  if(up){
    for(Pointer touch:touchesList){
      if(touch.id==event.getPointerId(idx)){
        t=touch;
        break;
      }
    }
    t.dead=true;
  }
  gestureDetector.onTouchEvent(event);
  return super.surfaceTouchEvent(event);
}
class Pointer {
  int id;
  float x, y,sx,sy,px,py;
  float area;
  float pressure;
  boolean dead=false;
}

class TouchManager extends GestureDetector.SimpleOnGestureListener{
  @Override
  boolean onScroll(MotionEvent e1, MotionEvent e2, float dx, float dy){
    return super.onScroll(e1,e2,dx,dy);
  }
  @Override
  boolean onDown(MotionEvent event){
    e.onDown();
    return super.onDown(event);
  }
}