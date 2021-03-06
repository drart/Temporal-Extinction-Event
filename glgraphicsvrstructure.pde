import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.opengl.*;
import javax.media.opengl.*;
import oscP5.*;
import controlP5.*;
ControlP5 controlP5; 
ControlWindow controlWindow;

// guidance on fake fullscreen hack
////   http://processing.org/discourse/yabb2/YaBB.pl?board=Syntax;action=display;num=1185318989
// tearing
// http://processing.org/discourse/yabb2/YaBB.pl?num=1235056546

float fadelevel = 0;
int section = 1;
float[] fades = {1.0,0.0,0.0};
int lastSection = 1;
int nextsection;
boolean doFades = false;
float flux; 
int index; 
float audioscaling = 1.0;
float[] spectrum;
float[] lastspectrum;

Minim minim;
FFT fft;
AudioInput input; 
LowPassFS lpf;
EffectsChain fx;
OscP5 oscP5;

PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;

void setup()
{
  size ( 1280, 768, OPENGL); 
  hint(DISABLE_OPENGL_2X_SMOOTH);
  //hint(ENABLE_OPENGL_4X_SMOOTH);   
  hint(DISABLE_OPENGL_ERROR_REPORT); // big speed improvement
  frameRate(30);
  ///http://processing.org/discourse/yabb2/YaBB.pl?num=1161698951
  oscP5 = new OscP5(this,12345);
  oscP5.plug(this, "OSCsectionchange", "/vr/tev/section"); 
  oscP5.plug(this, "OSCthreshold", "/vr/tev/threshold");
  oscP5.plug(this, "OSCscaling", "/vr/tev/level");
  
  points = new float[numberofpoints];  
  for ( int i = 0 ; i < numberofpoints/2; i++)  
  {    
    points[i] = sin( (float)i/numberofpoints*2 * TWO_PI) * height/2 + width/2;
    points[i+numberofpoints/2] = cos( (float)i/numberofpoints*2 * TWO_PI) * height/2 + height/2;
  }
  
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 512);// change to original setting?
  lpf = new LowPassFS(100, input.sampleRate());
  fx = new EffectsChain();
  fx.add(lpf);
  //input.addEffect(lpf);
  fx.enable(lpf);
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
  
  controlP5 = new ControlP5(this);
  controlP5.setAutoDraw(false);
  controlWindow = controlP5.addControlWindow("controlP5window",100,100,400,200);
  controlWindow.hideCoordinates();
  controlWindow.setBackground(color(40));
  controlP5.Controller mySlider = controlP5.addSlider("Threshold",0,100,40,40,300,40);
  mySlider.setWindow(controlWindow);
  controlP5.controller("Threshold").setValue(fluxthreshold);
  controlP5.Controller mySlider2 = controlP5.addSlider("Scaling", 0,2,40,100,300,40);
  mySlider2.setWindow(controlWindow);
  controlP5.controller("Scaling").setValue(audioscaling);
  
  //// FAKE FULLSCREEN ON SECOND SCREEN
  frame.setLocation(screen.width,-40);
  frame.setAlwaysOnTop(true); 
}

void draw()
{   
  controlP5.draw();

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

  }
    
    if (section == 1)
      beginsection(); 
    else if (section == 2)
      drawmiddle();
    else if (section == 3)
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
void mouseClicked(){  println(frameRate);  }

//// FAKE FULLSCREEN ON SECOND SCREEN
public void init() {
  frame.removeNotify();
  frame.setUndecorated(true);
  super.init();
} 
