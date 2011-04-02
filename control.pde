void keyPressed()
{
  if (key == '1')
  {
    lastSection = section;
    nextsection = 1;
    doFades = true;
    return;
  }
  if ( key == '2')
  {
    lastSection = section;
    nextsection = 2;
    doFades = true;
    return;
  }
  if (key == '3')
  {
    lastSection = section;
    nextsection = 3;
    doFades = true;
    return;
  }
  if ( key == '0')
  {
    background(0);
    return;
  }
  if ( key == 'f')
  {
    pushStyle();  
    noStroke();
    fill(0,6);
    rect(0,0,width,height);
    popStyle();
  } 
}

void OSCsectionchange(float t)
{
    int temp = (int) t;
    if(0 < temp && temp < 4)
    {
      lastSection = section;
      nextsection = temp;
      doFades = true;	
      println(temp);
    }
}

void OSCflash(float bogus)
{
   noStroke();
   fill(255);
   rect(0,0,width,height); 
   println("flash");
  
}

void OSCblank(float bogus){ background(0); }

void OSCscaling(float s)
{
   audioscaling = s; 
   controlP5.controller("Scaling").setValue(s);
}

void Scaling(float s)
{
   audioscaling = s; 
}

void OSCthreshold(float v)
{
  fluxthreshold = v;
  controlP5.controller("Threshold").setValue(v);
}

void Threshold(float v)
{
  fluxthreshold = v;
}


  void fadefunction()
  {   
    if (  fades[lastSection -1] <= 0.0)
    {
      fades[lastSection -1] = 0.0;
      section = nextsection;

      if ( fades[section-1] == 0.0)
        background(0);

      if ( fades[section-1] < 1.0)
      {
        fades[section-1] = fades[section-1] + 0.005;
      }
      else
      {
        fades[section-1] = 1.0;  
        doFades= false;
      }
    }
    else
    {
      fades[lastSection-1] = fades[lastSection-1] - 0.005;
    }
  }

