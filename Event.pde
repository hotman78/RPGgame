import org.luaj.vm2.*; 	
import org.luaj.vm2.lib.jse.*;
import org.luaj.vm2.lib.*;
import android.content.res.AssetManager;
class Event {
  public Globals globals;
  Event() {
    globals=JsePlatform.standardGlobals();
    loadAssets("shaders");
    globals.set("p", CoerceJavaToLua.coerce(pApplet));
    globals.set("e", CoerceJavaToLua.coerce(this));
    
  }
  private void loadAssets(String dir){
    AssetManager asset = getActivity().getResources().getAssets();
    try { 
      if(dir.equals("files"))return;
      String files[] =asset.list(dir);
      for(String file:files){
        if(file.equals(""))return;
        if(dir.equals("")){
          loadAssets(file);
          if(file.split("\\.")[file.split("\\.").length-1].equals("lua")&&!file.equals("lua")){
            String[] command=loadStrings(file);
            globals.load(join(command, "\n")).call();
          }
        }
        else{
          loadAssets(dir+"/"+file);
          if(file.split("\\.")[file.split("\\.").length-1].equals("lua")&&!file.equals("lua")){
            String[] command=loadStrings(file);
            globals.load(join(command, "\n")).call();
          }
        }
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}