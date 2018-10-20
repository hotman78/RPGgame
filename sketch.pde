import android.view.*;
import processing.event.TouchEvent.*;
import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import java.io.*;
public Stage stage;
public Event event;
public GestureDetector gestureDetector;
public PApplet pApplet=this;
public boolean pMousePressed=false;
public boolean mouseReleased=false;
public boolean mouseClicked=false;
public float startX=0,startY=0;
void onResume(){
  super.onResume();
  setUI();
}
void setup(){
  try{
  copyToLocal();
  }catch(IOException e){
    e.printStackTrace();
  }
  textSize(30);
  event=new Event();
  stage=new Stage();
  Activity act = getActivity();
  Context con = act.getApplicationContext();
  TouchManager tm=new TouchManager();
  Handler mHandler = new Handler(Looper.getMainLooper());
  gestureDetector =new GestureDetector(con, tm, mHandler);
}
void draw(){
  mouseReleased=!mousePressed&&pMousePressed;
  mouseClicked=mousePressed&&!pMousePressed;
  if(mouseClicked){
    startX=mouseX;
    startY=mouseY;
  }
  touches = touchesList.toArray(new Pointer[touchesList.size()]);
  for(Pointer t:touches){
    ellipse(t.x,t.y,10,10);
  }
  background(0);
  stage.draw();
  textSize(60);
  text(frameRate,0,60);
  noFill();
  for(Pointer t:touches)ellipse(t.x,t.y,100,100);
  synchronized (touchesList) {
    for(Pointer t:touchesList){
      if(t.dead)touchesList.remove(t);
    }
  }
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
private void copyToLocal() throws IOException { 
  String[] fileList = getActivity().getResources().getAssets().list("resource"); 
  if (fileList == null || fileList.length == 0) { 		
    return;
  } 	
  AssetManager as = getActivity().getResources().getAssets();
  InputStream input = null; 
  FileOutputStream output = null;
  for (String file : fileList) { 
    input = as.open("resource" + "/" + file); 
    output = getActivity().openFileOutput(file, getContext().MODE_WORLD_READABLE); 
    int DEFAULT_BUFFER_SIZE = 1024 * 4; 	
    byte[] buffer = new byte[DEFAULT_BUFFER_SIZE]; 	
    int n = 0; 		
    while (-1 != (n = input.read(buffer))) { 
      output.write(buffer, 0, n);
    } 		
    output.close(); 		
    input.close();
  }
}