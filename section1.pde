float[] xx;
float[] yy;

void beginsection()
{
  pushMatrix();
  pushStyle();  
  noStroke();
  fill(0,8 + 100 * (1-fades[0]) );
  rect ( 0,0, width, height );

  fill(200*fades[0],60); 
  translate(0,height/2); 
  
  for ( int i = 0 ; i < xx.length ; i++)
    ellipse(xx[i],yy[i],abs(flux),abs(flux));

  yy[index++%width] = flux;
  
  popStyle();
  popMatrix();
}
