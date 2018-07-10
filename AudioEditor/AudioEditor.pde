import controlP5.*;
import ddf.minim.*;
ControlP5 ui;
Minim minim;
AudioPlayer player = null;
DCanvas Dcanvas;
VCanvas Vcanvas;
LoadFile file;
Data  data;
Shapes shapes;
ControlGroup messageBox; 
ControlGroup messageBox2;
ControlGroup messageBox3;
AudioMetaData meta;


int x,y,x1,y1,Shape = 1,coso;
color SColor; 
color c = color(255,255,255);
float r,R,G,B,lx,ly,Size,lineOne,lineTwo,Time,Range;
PVector dcolor = new PVector(0,0,0);
int messageBoxResult= -1;
String messageBoxString = "";
int rango,vrango,stime;
String Path;
  boolean isDelete = false;
public enum Hstate {
  stop,
  draw,
  loop,
  none
  
}
Hstate state = Hstate.none;

void setup()
{
  size(1024,600);
  minim = new Minim(this);
 
  
  data = new Data();
  shapes = new Shapes();

  
  
  ui = new ControlP5(this);
  ui.addButton("ChargeFile")
  .setPosition(40,5)
  .setSize(100,35)
  .setLabel("Cargar archivo");
  
  ui.addButton("ExportFile")
  .setPosition(150,5)
  .setSize(100,35)
  .setLabel("Exportar archivo");
  
  ui.addButton("ChargeSong")
  .setPosition(260,5)
  .setSize(100,35)
  .setLabel("Cargar mp3");
  
  
 
  ui.addButton("ChargeShapeCu")
  .setPosition(40,330)
  .setSize(100,35)
  .setLabel("Cuadrado");
  
  
  ui.addButton("Looping")
  .setPosition(40,380)
  .setSize(100,35)
  .setLabel("Loop");
  
   ui.addButton("StopLooping")
  .setPosition(150,380)
  .setSize(100,35)
  .setLabel("StopLoop");

  
    ui.addButton("ChargeShapeCi")
  .setPosition(150,330)
  .setSize(100,35)
  .setLabel("Circulo");
  
 
   ui.addSlider("R", 0, 255, 0, 40, 436, 210, 25);//  Colores RGB
   ui.addSlider("G", 0, 255, 0, 40, 466, 210, 25);//  Colores RGB
   ui.addSlider("B", 0, 255, 0, 40, 496, 210, 25);//  Colores RGB
   ui.addSlider("Time", 0, 10, 1, 40, 220, 210, 25); // rango
   

   
   
  ui.addSlider("Size", 10, 25, 20, 40, 295, 210, 25);
  ui.addSlider("Range", 1, 13000, 1, 40, 260, 210, 25);
   
   ui.getController("Size").setValue(Size);
   ui.getController("Time").setValue(Time);
   ui.getController("Range").setValue(Range);
 
 
   ui.getController("R").setValue(R);
   ui.getController("G").setValue(G);
   ui.getController("B").setValue(B);
   
 
    ui.addButton("Ayudar")
    .setPosition(700,10)
    .setSize(100,35)
    .setLabel("Help");
    
  createMessageBox(); 
 
}

void drawUi()
{
 
//  
   
   
   Dcanvas = new DCanvas();
   Vcanvas = new VCanvas();
   

     if(player != null){ 
 
    
     state = state.draw;
     
      if(player.length() < 15000)
    {
      player.close();
      state = state.stop;


     
    }
     
     
     
     
     
     
  }
    
   
 }





void updateUi()
{

  if(player != null && state == state.draw){ 
   
  ui.getController("Time").setMax(player.length()-Range);
  }
  if(state == state.loop)
  {
  
     ui.getController("Time").lock();
     ui.getController("Range").lock();
    
  }else{
     ui.getController("Time").unlock();  
     ui.getController("Range").unlock();  
  }
}

void ChargeSong()
{
   selectInput("Ruta del mp3", "fileSong");
}

void ChargeFile()
{
 selectInput("Ruta de lectura", "fileSelected");
}

void ExportFile()
{
 selectOutput("Ruta de guardado", "fileSave");
}

void ChargeShapeCu()
{
 Shape = 1;
}

void ChargeShapeCi()
{
 Shape = 2;
}


void Looping()
{
    if(state == state.draw)
    {
   state = state.loop;
     }
    if(state == state.loop)
  {
     player.play();
  int tm = Math.round(Time);  
  int ltm = Math.round(Time+ Range);

    
    player.setLoopPoints(tm, ltm);
    
    print(tm);
     player.loop(9999); 
    

  }
  
}

void StopLooping()
{
     if(state == state.loop)
  {
    player.loop(0);
    
    player.rewind();
    player.pause(); 
    state = state.draw;
  }
}
   


void draw()
{
   
  background(#B44C43);
 
     
  if(state == state.draw || state == state.loop  || state == state.stop){
  Dcanvas.draw();
  Vcanvas.draw();
  updateUi();
  }

}



void keyPressed()
{

 if(player.isPlaying())
 {
   player.pause();
 }else
 {
  player.play(); 
  
 
 }

}



void mouseClicked()
{
  if(state == state.draw && state != state.none ){
  if ( mouseButton == RIGHT )
  {
    isDelete = true;
     
   Dcanvas.Press();
   dcolor.set(R,G,B);
    updateUi();
     
  }
  else
  {
    isDelete = false;
    
   Dcanvas.Press();
   dcolor.set(R,G,B);
    updateUi();
  
  
  }
  
  
  }
  
 
  
}

 





void fileSelected(File selection) {
  if (selection == null) {
    println("ruta de lectura no escogida");
  } 
  else 
  {
       shapes.ShapePoints.clear();
    if(player != null)
    {
      state = state.none;
      player.close();
        
    }
   
    
    Path = selection.getAbsolutePath();
    file = new LoadFile();
    file.load();
    
    drawUi();
    
    
  }
}

void fileSave(File selection) {
  if (selection == null) {
    println("ruta de guardado no escogida");
  } 
  else if(player != null)
  {
     meta = player.getMetaData();
     data.fileSong(meta.fileName());
    Path = selection.getAbsolutePath();
    data.savedata(60);
   
    
  }
}

void fileSong(File selection) {
  if (selection == null) {
    println("ruta de lectura no escogida");
  } 
  else 
  {
    
    if( player != null){
       player.close();
  
       shapes.ShapePoints.clear();
    }
  
  //  background(c);
    Path = selection.getAbsolutePath();
    player = minim.loadFile(Path,512); 
    
  
    if(player.length() < 15000)
    {
      print("No aceptado");
   
      player.close();
      drawUi();
     
    }
   
    data.fileSong(Path);
    
    drawUi();
    
   
  }
}



void Ayudar(int theValue){
 println("ayuda para el usuario" + theValue);
  if(messageBox.isVisible()) {
    messageBox.hide();
    messageBox2.hide();
    messageBox3.hide();
  } else {
    messageBox.show();
    messageBox2.show();
    messageBox3.show();
  }
  
  
}



void createMessageBox(){
    messageBox = ui.addGroup("Help",20,215,250);
 messageBox.setBackgroundHeight(330);
 messageBox.setBackgroundColor(color(0,100));
 messageBox.hide();
  
  // add a TextLabel to the messageBox
  ui.addTextlabel("messageBoxLabel","Te permite determinar el tiempo de la ",1,10)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
  
   ui.addTextlabel("messageBoxLabelw","cancion que quieres trabajar",1,25)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
 
 ui.addTextlabel("messageBoxLabelwe","Determina el area del tiempo que eligistes",1,40)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
  
   ui.addTextlabel("messageBoxLabelwer","y cuantos cuadrados debe aver en la cuadrilla",1,55)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
  
  ui.addTextlabel("messageBoxLabelhe","Determinas del tamaño del objeto",1,85)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
  
  ui.addTextlabel("messageBoxLabelq","Estos dos botones crean los circulos" ,1,110)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
  
  ui.addTextlabel("messageBoxLabelz","y cuadrados en la cuadrilla",1,125)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
  
  ui.addTextlabel("messageBoxLabelwegt","Estos botones  comiensan y paran la",1,165)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
  
  ui.addTextlabel("messageBoxLabelhy","canción segun el RANGE y el TIME",1,180)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
  
  ui.addTextlabel("messageBoxLabeljk","Determinan el color del objeto",1,210)
  .setFont(createFont("Georgia", 10))
  .setColorValue(#EDFF21)
  .moveTo(messageBox);
 
 messageBox2 = ui.addGroup("Help2",300,215,300);
 messageBox2.setBackgroundHeight(100);
 messageBox2.setBackgroundColor(color(0,100));
 messageBox2.hide();
  
  // add a TextLabel to the messageBox.
   ui.addTextlabel("messageBoxLabel2","Aqui puedes poner los cuadrado y circulos ",20,20)
  .setFont(createFont("Georgia", 10))
  .moveTo(messageBox2);
  
  messageBox3 = ui.addGroup("Help3",50,50,400);
 messageBox3.setBackgroundHeight(100);
 messageBox3.setBackgroundColor(color(0,100));
 messageBox3.hide();
  
  // add a TextLabel to the messageBox.
  ui.addTextlabel("messageBoxLabel3","Aqui se mostraran los cuadrado y circulos que creastes en la cuadrilla ",20,20)
  .setFont(createFont("Georgia", 10))
  .moveTo(messageBox3);
}
  
