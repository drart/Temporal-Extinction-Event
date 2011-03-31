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

  if ( key == 'a')
  {
    fluxampvalue += .15;
    return;
  }

  if (key == 'z')
  { 

    fluxampvalue -= .05;
    return;
  }

  if (key == ' ')
  {
    fluxampvalue = .5;
    return;
  }

  if ( key == '0')
  {
    background(0);
    return;
  }
}


void OSCsectionchange(int temp)
{
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
   //audioscaling = s; 
}

void OSCthreshold(int v)
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

