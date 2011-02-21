import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.opengl.*;
import javax.media.opengl.*;

//import fullscreen.*;
//import codeanticode.glgraphics.*;

float fadelevel = 0;
int section = 1;
float[] fades = {1.0,0.0,0.0};
int lastSection = 1;
int nextsection;
boolean doFades = false;
float flux; 
int index; 
float fluxampvalue = .5;
float[] spectrum;
float[] lastspectrum;

Minim minim;
FFT fft;
AudioInput input; 
  
void setup()
{
  //size ( 1366, 768, OPENGL); // native resolution for EPCOR CENTRE projectors
  size ( 1280, 768, OPENGL); 
  //size(960,540, OPENGL);
  //size(720, 480, OPENGL);
  hint(DISABLE_OPENGL_2X_SMOOTH);
  hint(ENABLE_OPENGL_4X_SMOOTH);   
  //hint(DISABLE_OPENGL_ERROR_REPORT); // big speed improvement
    
  points = new float[numberofpoints];  
  for ( int i = 0 ; i < numberofpoints/2; i++)  
  {    
    points[i] = sin( (float)i/numberofpoints*2 * TWO_PI) * height/2 + width/2;
    points[i+numberofpoints/2] = cos( (float)i/numberofpoints*2 * TWO_PI) * height/2 + height/2;
  }
  
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 256);
  fft = new FFT(input.bufferSize(), input.sampleRate());
  fft.noAverages();  
  
  
  for (int i = 0 ; i < numberoflines ; i++)
  {
    x[i] = random(-width, width);
    y[i] = random(-height, height);
    z[i] = random(0,500);
  }
  
    
  spectrum = new float[fft.specSize()];
  lastspectrum = new float[fft.specSize()];
  Arrays.fill( lastspectrum, 0 ); 
  
  
  xx = new float[width];
  yy = new float[width];

  for (int i = 0; i < xx.length ; i++)
    xx[i] = (float)i ;
    
  background(0);
  noCursor();
}


void draw()
{    
  if (section != 2)
  {  
    fft.forward(input.mix);
    ///------------------------
    // SPECTRAL FLUX
    ///------------------------
    flux = 0;
    for( int i = 0 ; i < fft.specSize() ; i++)
    {
      spectrum[i] = fft.getBand(i);
      flux += spectrum[i] - lastspectrum[i]; 
      // rectified flux
      // float fluxval = spectrum[i] - lastspectrum[i];
      // flux += (fluxval > 0.0 ) ? fluxval : 0.0;
    }
    System.arraycopy( spectrum, 0, lastspectrum, 0, spectrum.length ); 
    flux = flux * fluxampvalue;
  }
    
    if (section == 1)
      beginsection();
      
    if (section == 2)
      drawmiddle();
  
    if (section == 3)
      endsection();
      
    if (doFades)
    {
       fadefunction();     
    }
}

void stop()
{
  input.close();
  minim.stop();
  super.stop();
}

void mouseClicked()
{
 println(frameRate);  
}
