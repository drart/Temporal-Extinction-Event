float[] points;
int numberofpoints = 80000;
float fluxthreshold = 30;

void endsection()
{
  lpf.setFreq(700);
  fx.enable(lpf);
  float audiolevel = input.mix.level();
  
  fill(0, 5);
  noStroke();
  rect(0, 0, width, height);
  
  // http://processing.org/discourse/yabb2/YaBB.pl?num=1212706445/1
  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  
  gl.glPushMatrix();
  gl.glBegin(gl.GL_POINTS);
  gl.glColor3f(audioscaling*100*audiolevel*fades[2],audioscaling*100*audiolevel*fades[2],audioscaling*100*audiolevel*fades[2]); // 60/255 
  
  for ( int i = 0 ; i < numberofpoints/2; i++)  
    gl.glVertex2f( points[i], points[i+numberofpoints/2] );
  gl.glEnd();
  
  gl.glPopMatrix();
  pgl.endGL(); //end opengl

  for (int i = 0; i < points.length ; i++)
    points[i] += random(-1.6, 1.6);

  if (flux > fluxthreshold)
  {
    noStroke();
    fill(255);
    rect(0, 0, width, height);
  }
}

