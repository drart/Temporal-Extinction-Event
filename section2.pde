int r;
int numberoflines = 9000;

float[] x = new float [numberoflines];
float[] y = new float [numberoflines];
float[] z = new float [numberoflines];

void drawmiddle()
{ 
  pushMatrix();
  pushStyle();

  background(0);
  stroke(255*fades[1],60);
  translate(width/2, height/2,-500);
  rotate((float)r++/950);
  noFill();
  strokeWeight(4);
  beginShape();
  for (int i = 0; i < x.length; i++)
  {
    vertex( x[i], y[i], z[i]);
  }
  endShape(); 

  for (int i = 0; i < x.length; i++)
  {
    x[i] += random(-1,1);
    y[i] += random(-1,1);
    z[i] += random(-1,1);

    z[i] += random( (float) i * .0002);
  }  

  popStyle();
  popMatrix();
}

