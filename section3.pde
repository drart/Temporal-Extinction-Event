float[] points;
int numberofpoints = 50000;
float fluxthreshold = 70;

void endsection()
{
  // http://processing.org/discourse/yabb2/YaBB.pl?num=1212706445/1
  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl
  
  pushMatrix();
  pushStyle();
  fill(0,5);
  noStroke();
  rect(0,0,width,height);
  fill(255);
  
  for (int i = 0; i < points.length ; i++)
     points[i] += random(-2,2);
  
  float audiolevel = input.mix.level();
  
  stroke(audiolevel*1000*fades[2]);
  strokeWeight(1);
  
  for ( int i = 0 ; i < numberofpoints/2; i++)  
    point( points[i] , points[i+numberofpoints/2] );
    
    
  if (flux > fluxthreshold)
  {
   noStroke();
   fill(255);
   rect(0,0,width,height); 
 }  
 popStyle();
 popMatrix();
    
}

