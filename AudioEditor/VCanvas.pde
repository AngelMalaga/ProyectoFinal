class VCanvas
{ 
  PGraphics buffer;
  color c = color(255,255,255);
  int loopBegin;
int loopEnd;
  
  public VCanvas()
  {
   buffer = createGraphics(1000,150);
  }
  
   void draw()
   {
     
     
 
  buffer.beginDraw();
  buffer.background(c);
 
 
  int p = player.position();
  int l = player.length();
  float x = map(p, 0, l, 0, buffer.width);
  buffer.stroke(#0A0A0A);
  buffer.line(x, 0, x, buffer.height);
  
  
   lineOne = map(Time, 0, player.length(), 0, buffer.width);
   lineTwo = map(Time+Range, 0, player.length(), 0, buffer.width);
   
  float lbx = map(loopBegin, 0, player.length(), 0, width);
  float lex = map(loopEnd, 0, player.length(), 0, width);
   

  
  buffer.stroke(165,165,165,50);
  
   float t = 0;
  if(vrango != 0)
  {
  
      t = 1000.0 / vrango;

  }
  
  for (int i = 0; i <= vrango; i++)
  {
  
   buffer.line(t * i, 0, t * i, height);
    
  }
   for (int i = 0; i <= 7; i++)
  {
    
    buffer.line(0, 22 * i , width, 22 * i  );  
  }
  



   
   buffer.stroke(0,200,0);
   buffer.line(lineOne, 0,lineOne, height);
   buffer.stroke(255,5,5);
   buffer.line(lineTwo, 0, lineTwo, height);
   drawShapes();
   buffer.endDraw();
   image(buffer,12,50);
   Time();
  

   }

    void Time()
    {
    rango = (Math.round(Range))/1000; 
    vrango = (Math.round(player.length()))/1000; 
 
    }
    

      void drawShapes()
    {
      buffer.beginDraw();
      for (int i = 0; i < shapes.ShapePoints.size(); i ++ )
     {
      shapes.ShapePoints.get(i).vdrawShape();
      }
      buffer.endDraw();
    }
    
 
    float lastPos = 0;

}
