class ObjectManager{
  ArrayList<Obj> object;
  ObjectManager(){
    object=new ArrayList<Obj>();
  }
  Obj addObject(int x,int y){
    Obj obj=new Obj(x,y);
    object.add(obj);
    return obj;
  }
  Player addPlayer(int x,int y){
    Player player=new Player(x,y);
    object.add(player);
    return player;
  }
  void removeObject(Obj obj){
    object.remove(object.indexOf(obj));
  }
  void draw(){
    for(int i=0;i<object.size();i++){
      object.get(i).draw();
    }
  }
  Obj exist(int x,int y){
    for(int i=0;i<object.size();i++){
      if(object.get(i).x==x&&object.get(i).y==y)return object.get(i);
    }
    return null;
  }
}