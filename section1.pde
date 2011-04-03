float[] xx;
float[] yy;

void beginsection()
{
  lpf.setFreq(5000);
  fx.disable(lpf);
  noStroke();
  fill(0, 6 + 100 * (1-fades[0]) );
  rect ( 0, 0, width, height );

  pushMatrix();
  pushStyle();  
  noStroke();
  fill(0,8 + 100 * (1-fades[0]) );
  rect ( 0,0, width, height );
   
   fill(250*fades[0],60); 
   translate(0,height/2); 
   
   for ( int i = 0 ; i < xx.length ; i++)
   {
     ellipse(xx[i],yy[i], input.mix.level()*600*audioscaling, input.mix.level()*600*audioscaling);
     //yy[( index + i ) % width] = yy[( index + i ) % width] * (1 - (i / xx.length));
   }
  
  yy[index++%width] = flux * 2;
  
  
  popStyle();
  popMatrix();
}



  /*
  /// opengl experiment
  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  gl.glPushMatrix();

  gl.glTranslatef(0.0, height/2.0, 0.0);
  gl.glColor3f(audioscaling*fades[0], audioscaling*fades[0], audioscaling*fades[0]); // 60/255 

  gl.glBegin(gl.GL_POINTS);
  gl.glPointSize((int) (audioscaling * abs(flux)) );  
  for ( int i = 0 ; i < xx.length ; i++)
    gl.glVertex2f(xx[i], yy[i]);
  gl.glEnd();

  gl.glPopMatrix();
  pgl.endGL(); //end opengl
  */

