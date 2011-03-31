int r;
int numberoflines = 9000;

float[] x = new float [numberoflines];
float[] y = new float [numberoflines];
float[] z = new float [numberoflines];

void drawmiddle()
{ 
  background(0);
  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  //gl.setSwapInterval(1); //set vertical sync on

    
  pushMatrix();
  pushStyle();


  //stroke(255*fades[1],60);
  translate(width/2, height/2,-500);
  rotate((float)r++/1500.0);
  //noFill();
  //beginShape();
  gl.glLineWidth(4);
  gl.glBegin(gl.GL_LINE_STRIP);
  for (int i = 0; i < x.length; i++)
  {

    gl.glColor4f(fades[1], fades[1], fades[1], 0.235294118); // 60/255
    gl.glVertex3f( x[i], y[i], z[i]);
    //vertex( x[i], y[i], z[i]);
  }
  gl.glEnd();
  //endShape(); 
  pgl.endGL(); //end opengl
  
  for (int i = 0; i < x.length; i++)
  {
    x[i] += random(-0.5,0.5);
    y[i] += random(-0.5,0.5);
    z[i] += random(-0.5,0.5);

    z[i] += random( (float) i * .0001);
  }  

  popStyle();
  popMatrix();
}

