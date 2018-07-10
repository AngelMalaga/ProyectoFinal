class DCanvas
{ 

  PGraphics buffer;
  float lastPos = 0;

  public DCanvas()
  {
   buffer = createGraphics(700,340);


  }
   
   void draw()
   {

   buffer.beginDraw();
   
    drawLines();
    if(state == state.draw || state == state.stop)
    {
      update();
       
         if(player.length() < 15000)
          {
           menssage();
           
          }
    
    }
 
 
    if(state == state.loop )
  {
    Dcanvas.BeginLoop();
  }
   
   buffer.endDraw();
  
  
  image(buffer,300,210);
   }
   
  
  
  
 void drawLines()
{
  buffer.beginDraw();
  buffer.background(c);
  buffer.stroke(180);
  buffer.strokeWeight(1);
  
  for (int i = 0; i <= rango; i++)
  {
    buffer.line(50 * i, 0, 50 * i, height); // filas
    
  }
   for (int i = 0; i <= 20; i++)
  {
    
    buffer.line(0, 50 * i-210 , width, 50 * i-210 );  // columnas
  }
  
  

  buffer.endDraw();
}
  void menssage()
  {
     buffer.beginDraw();
     buffer. textSize(32);
     buffer. text("Archivo de audio inferior", 50, 210); 
     buffer. text("al minimo aceptado", 50, 250); 
     buffer. fill(#FF0000);
     buffer.endDraw();
   }
  

void Press()
 {

  if(isDelete == false)
  {
  float x = (50 *  (mouseX  / 50 )) -300 ;
  float y = (50 *  (mouseY  / 50 )) -210;
  if(x >=0 && x < 700 && y < 350 && y > 0){
       print("x: "+x);
  float map = map(x, 0, buffer.width, 0, 14);
  int time = (Math.round(map)); 
  float TR = Time + time*1000;
  stime = time;

  shapes.ShapePoints.add(new ShapeCreator(x,y,Shape,Size,dcolor,TR));
  
     }
  
  }
  else if(isDelete == true)
  {
    
     float x = (50 *  (mouseX  / 50 )) -300 ;
     float y = (50 *  (mouseY  / 50 )) -210;
     if(x >=0){
     float map = map(x, 0, buffer.width, 0, 14);
     int time = (Math.round(map)); 
     float TR = Time + time*1000;
     stime = time;

     
      for (int i = 0; i < shapes.ShapePoints.size(); i ++ )
     {
      float[] dato = shapes.ShapePoints.get(i).getData();
       if(dato[0] == x && dato[1] == y)
       {
         shapes.ShapePoints.remove(i);
       }
      
      }
     
     }
  }
  

  
 }

    
    void update()
    {
       if(shapes.ShapePoints.size()>0)
            {
             for(int i = 0; i < shapes.ShapePoints.size(); i++)
              {
               
                float nextPos = Time + Range;
                float[] data = new float[7];
                data = shapes.ShapePoints.get(i).getData();
                 lastPos = data[7];
                 if(lastPos >= Time && lastPos <= nextPos)
                 {
                  shapes.ShapePoints.get(i).drawShape();
                 }
              }
             
            }
    }
  
  
  
  void BeginLoop() 
  {
    

      
  for (int i = 0; i < shapes.ShapePoints.size(); i ++ )
  {
   
      float nextPos = Time + Range;
                float[] data = new float[7];
                data = shapes.ShapePoints.get(i).getData();
                 lastPos = data[7];
                 if(lastPos >= Time && lastPos <= nextPos && data[7]<player.position())
                  {
                
                   shapes.ShapePoints.get(i).moveShape();
                  }
                 
                  
                  
                 }
    
      }
  
    
    
  }
  
 
  
