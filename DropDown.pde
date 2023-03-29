 
 
 
class DropDown
{
  float x, y;
  int textSize = 24;
  String title;
  PFont font;
  Boolean isOpen = false;
  int index;
  int buffer;
  int exBuffer = 0;
  float boxW,boxH,boxX,boxY;
  SearchBar child;
   DropDown(float x, float y, String title, PFont font, int buffer)
   {
     this.x = x;
     this.y = y;
     this.title = title;
     this.font = font;
     this.buffer = buffer;
     child = new SearchBar(round(x),round(y+buffer),200,40,font);
   }
   
   void update()
   {
     this.index = dropList.indexOf(this);
     
     exBuffer = 0;
     for (int i = 0; i < index; i++)
     {
       if (dropList.get(i).isOpen)
       {
         exBuffer += dropList.get(i).buffer;
         
       }
     }
     //println(index + " "+ isOpen);
     
     boxW = 300;
     boxH = textSize*2;
     boxX = x-textSize/2;
     boxY = y-textSize+exBuffer;
     if (mouseOver())
     {
       stroke(255);
     }else
     {
       stroke(0);
     }
     if (isOpen)
     {
       fill (180);
       rect(boxX, boxY, boxW, boxH+buffer);
     }
     fill(100);
     rect(boxX,boxY,boxW,boxH);
     fill(255);
     textFont(font);
     text(title, x,y+exBuffer);
     
     if (!isOpen)
     {
       triangle(x+title.length()*textSize/2.2, y-(textSize/2) -4 + exBuffer, x+24+title.length()*textSize/2.2, y-(textSize/2) -4 + exBuffer, x+12+title.length()*textSize/2.2, y+4 + exBuffer);
     }else
     {
        triangle(x+title.length()*textSize/2.2, y+(textSize/2) -12 + exBuffer, x+24+title.length()*textSize/2.2, y+(textSize/2) -12 + exBuffer, x+12+title.length()*textSize/2.2, y-20 + exBuffer);
        //child.y += exBuffer;
         child.y = (int)y+exBuffer+(buffer);
        child.update();
     

        
     }
     stroke(0);
     

   }
   
  boolean mouseOver()
  {
    //checks if the mouse is in collision with the text box
    if (mouseX > boxX && mouseX < boxX+boxW)
    {
      if (mouseY > boxY && mouseY < boxY+boxH)
      {
        return true;
      }
    }
    return false;
  }
  
  void mouseIn()
  {
    if (isOpen)
    {
      child.mouseIn();
    }
    //if the mouse is over, and pressed the box will be opened
    if (mouseOver())
    {
      isOpen ^= true;
    }
  }
  void keyIn()
  {
     child.keyIn();
  }
   
}
