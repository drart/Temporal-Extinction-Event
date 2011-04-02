int r;
int numberoflines = 8000;

float[] x = new float [numberoflines];
float[] y = new float [numberoflines];
float[] z = new float [numberoflines];

void drawmiddle()
{ 
  background(0);
  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  //gl.setSwapInterval(1); //set vertical sync on

  gl.glPushMatrix();
  gl.glTranslatef((float)width/2, (float)height/2,-500.0);
  gl.glRotatef((float)r++/30.0, 0,0,1);
  gl.glLineWidth(3);
  gl.glBegin(gl.GL_LINE_STRIP);
  for (int i = 0; i < x.length; i++)
  {
    gl.glColor4f(fades[1], fades[1], fades[1], 0.235294118); // alpha is 60/255 like original sketch
    gl.glVertex3f( x[i], y[i], z[i]);
  }
  gl.glEnd();
  
  for (int i = 0; i < x.length; i++)
  {
    x[i] += random(-0.5,0.5);
    y[i] += random(-0.5,0.5);
    z[i] += random(-0.5,0.5);
    z[i] += random( (float) i * .0001);
  }  
  gl.glPopMatrix();
  pgl.endGL(); //end opengl
}

