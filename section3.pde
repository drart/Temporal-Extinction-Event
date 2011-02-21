float[] points;
int numberofpoints = 50000;
float fluxthreshold = 35;

void endsection()
{
  pushMatrix();
  pushStyle();
  fill(0,5);
  noStroke();
  rect(0,0,width,height);
  fill(255);
  
  for (int i = 0; i < points.length ; i++)
     points[i] += random(-2,2);
  
  float audiolevel = input.mix.level();
  
  stroke(audiolevel*500*fades[2]);
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

