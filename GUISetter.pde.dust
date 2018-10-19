class GuiSetter{
  ArrayList<GUI> guis;
  GuiSetter(){
    guis=new ArrayList<GUI>();
  }
  Button addButton(int x,int y,int sizeX,int sizeY,String text,Event event){
    Button button=(Button)new Button(x,y,sizeX,sizeY,text,event);
    guis.add(button);
    return button;
  }
  
  TextWindow addTextWindow(int x,int y,int sizeX,int sizeY,String text){
    TextWindow textWindow =(TextWindow)new TextWindow(x,y,sizeX,sizeY,text);
    guis.add(textWindow);
    return textWindow;
  }
  OptionWindow addOptionWindow(int x,int y,int sizeX,int sizeY,LuaTable text,Event event){
    OptionWindow optionWindow=(OptionWindow)new OptionWindow(x,y,sizeX,sizeY,event).setOptions(text);
    guis.add(optionWindow);
    return optionWindow;
  }
  void remove(GUI gui){
    guis.remove(guis.indexOf(gui));
  }
  void draw(){
    for(int i=0;i<guis.size();i++){
      if(guis.get(i).dead)guis.remove(i);
      else guis.get(i).draw();
    }
  }
}
