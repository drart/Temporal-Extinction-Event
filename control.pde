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

