import guru.ttslib.*;
import processing.video.*;

import beads.*;
import controlP5.*;
import java.util.*;

ControlP5 p5;
Movie rehabVid;
boolean showVid;
Reverb reverb;
BiquadFilter filter;

WavePlayer sineLeft; 
WavePlayer sineRight;
WavePlayer sineUp;
WavePlayer sineDown;

WavePlayer sawLeft;
WavePlayer sawRight;
WavePlayer sawUp;
WavePlayer sawDown;
WavePlayer modulator;

SamplePlayer align;

Glide sineGlide;
Gain sineGain;

Glide sineLeftGlide;
Glide sineRightGlide;
Glide sineUpGlide;
Glide sineDownGlide;

Gain sineLeftGain;
Gain sineRightGain;
Gain sineUpGain;
Gain sineDownGain;

Glide sawGlide;
Gain sawGain;

Glide sawLeftGlide;
Glide sawRightGlide;
Glide sawUpGlide;
Glide sawDownGlide;

Gain sawLeftGain;
Gain sawRightGain;
Gain sawUpGain;
Gain sawDownGain;

Gain sumSinesGain;
Gain sumSawsGain;

Gain modulatorGain;

Gain alignmentGain;
Glide alignmentGlide;

Gain g;
Glide gainGlide;
Envelope gainEnvelope;
Gain masterGain;

Button leftButton;
Button rightButton;
Button upButton;
Button downButton;
Button alignButton;

Slider2D xyGrid;
Slider leftSlider;
Slider rightSlider;
Slider upSlider;
Slider downSlider;
Slider alignmentSlider;
Slider GainSlider;

boolean sp = false;
Panner p;
float LEFT = -1.0;
float RIGHT = 1.0;
float panner = LEFT;

TextToSpeechMaker ttsMaker;
Button bodyAngle;
Button saxophone;
String bodyPosition = "You've reached a bad body angle, please readjust your arm.";
String exercise1Json = "exercise1.json";
String exercise2Json = "exercise2.json";
String exercise3Json = "exercise3.json";

NotificationServer server;
ArrayList<Notification> notifications;

Example example;

PriorityQueue<Notification> q2;

boolean training = false;
boolean minInv = false;
Button trainingTog;
Button minimumTog;
Button exercise1;
Button exercise2;
Button exercise3;

void setup() {
  size(700,700);
ac = new AudioContext();
p5 = new ControlP5(this);

rehabVid = new Movie(this, "rehab.mp4");

sineLeft = new WavePlayer(ac, 349, Buffer.SINE);
sineRight = new WavePlayer(ac, 440, Buffer.SINE);
sineUp = new WavePlayer(ac, 523, Buffer.SINE);
sineDown = new WavePlayer(ac, 659, Buffer.SINE);

sawLeft = new WavePlayer(ac, 349, Buffer.SQUARE);
sawRight = new WavePlayer(ac, 440, Buffer.SQUARE);
sawUp = new WavePlayer(ac, 523, Buffer.SQUARE);
sawDown = new WavePlayer(ac, 659, Buffer.SQUARE);

modulator = new WavePlayer(ac, 0, Buffer.SINE);
modulatorGain = new Gain(ac, 1, modulator);

alignmentGlide = new Glide(ac, .5, 50);
alignmentGain = new Gain(ac, 1, alignmentGlide);

sumSinesGain = new Gain(ac, 1, 0.2);
sumSawsGain = new Gain(ac, 1, 0.2);

sineLeftGlide = new Glide(ac, 1, 300);
sineRightGlide = new Glide(ac, 1, 300);
sineUpGlide = new Glide(ac, 1, 300);
sineDownGlide = new Glide(ac, 1, 300);

sineLeftGain = new Gain(ac, 1, sineLeftGlide);
sineRightGain = new Gain(ac, 1, sineRightGlide);
sineUpGain = new Gain(ac, 1, sineUpGlide);
sineDownGain = new Gain(ac, 1, sineDownGlide);

sawLeftGlide = new Glide(ac, 0, 300);
sawRightGlide = new Glide(ac, 0, 300);
sawUpGlide = new Glide(ac, 0, 300);
sawDownGlide = new Glide(ac, 0, 300);

sawLeftGain = new Gain(ac, 1, sawLeftGlide);
sawRightGain = new Gain(ac, 1, sawRightGlide);
sawUpGain = new Gain(ac, 1, sawUpGlide);
sawDownGain = new Gain(ac, 1, sawDownGlide);

sawGlide = new Glide(ac, .5, 50);
sawGain = new Gain(ac, 1, sawGlide);

gainGlide = new Glide(ac, .5, 300);
p = new Panner(ac, panner);
p.setPos(0);
gainEnvelope = new Envelope(ac, 0.0);
g = new Gain(ac, 1, gainEnvelope);
masterGain = new Gain(ac, 1, gainGlide);

align = getSamplePlayer("alignment.wav");
align.pause(true);

ttsMaker = new TextToSpeechMaker();

sawLeftGain.addInput(sawLeft);
sineLeftGain.addInput(sineLeft);
sawRightGain.addInput(sawRight);
sineRightGain.addInput(sineRight);
sawUpGain.addInput(sawUp);
sineUpGain.addInput(sineUp);
sawDownGain.addInput(sawDown);
sineDownGain.addInput(sineDown);

sumSinesGain.addInput(sineLeftGain);
sumSinesGain.addInput(sineRightGain);
sumSinesGain.addInput(sineUpGain);
sumSinesGain.addInput(sineDownGain);

sumSawsGain.addInput(sawLeftGain);
sumSawsGain.addInput(sawRightGain);
sumSawsGain.addInput(sawUpGain);
sumSawsGain.addInput(sawDownGain);

modulatorGain.addInput(sumSinesGain);
modulatorGain.addInput(sumSawsGain);

alignmentGain.addInput(align);

g.addInput(modulatorGain);
g.addInput(alignmentGain);

g.addInput(sumSawsGain);
g.addInput(sumSinesGain);
masterGain.addInput(g);
p.addInput(masterGain);
ac.out.addInput(p);


GainSlider = p5.addSlider("GainSlider")
    .setPosition(25, 180)
    .setSize(600, 20)
    .setRange(0, 100)
    .setValue(50)
    .setLabel("Volume");
    
leftSlider = p5.addSlider("leftSlider")
    .setPosition(355, 70)
    .setSize(20, 80)
    .setRange(0, 100)
    .setValue(50)
    .setLabel("");
    
rightSlider = p5.addSlider("rightSlider")
    .setPosition(455, 70)
    .setSize(20, 80)
    .setRange(0, 100)
    .setValue(50)
    .setLabel("");

upSlider = p5.addSlider("upSlider")
    .setPosition(555, 70)
    .setSize(20, 80)
    .setRange(0, 100)
    .setValue(50)
    .setLabel("");
    
downSlider = p5.addSlider("downSlider")
    .setPosition(655, 70)
    .setSize(20, 80)
    .setRange(0, 100)
    .setValue(50)
    .setLabel("");

alignmentSlider = p5.addSlider("alignmentSlider")
    .setPosition(255, 70)
    .setSize(20, 80)
    .setRange(0, 100)
    .setValue(50)
    .setLabel("");

xyGrid = p5.addSlider2D("xyGrid")
    .setPosition(30, 250)
    .setMinMax(-3, -3, 3, 3)
    .setLabel("Weight Dist");
    
leftButton = p5.addButton("swipeLeft").setPosition(340, 30).setSize(50, 30).setLabel("swipeLeft").activateBy(ControlP5.RELEASE);
rightButton = p5.addButton("swipeRight").setPosition(440, 30).setSize(50, 30).setLabel("swipeRight").activateBy(ControlP5.RELEASE);
upButton = p5.addButton("swipeUp").setPosition(540, 30).setSize(50, 30).setLabel("swipeUp").activateBy(ControlP5.RELEASE);
downButton = p5.addButton("swipeDown").setPosition(640, 30).setSize(50, 30).setLabel("swipeDown").activateBy(ControlP5.RELEASE);
alignButton = p5.addButton("align").setPosition(240,30).setSize(50, 30).setLabel("Alignment").activateBy(ControlP5.RELEASE);
bodyAngle = p5.addButton("bodyAngle").setPosition(125, 30).setSize(100, 30).setLabel("BodyPosition").activateBy(ControlP5.RELEASE);

saxophone = p5.addButton("saxophone").setPosition(125, 75).setSize(100, 30).setLabel("Saxophone").activateBy(ControlP5.RELEASE);

exercise1 = p5.addButton("exercise1").setPosition(10, 30).setSize(100, 30).setLabel("Exercise Test 1").activateBy(ControlP5.RELEASE);
exercise2 = p5.addButton("exercise2").setPosition(10, 75).setSize(100, 30).setLabel("Exercise Test 2").activateBy(ControlP5.RELEASE);
exercise3 = p5.addButton("exercise3").setPosition(10, 75+45).setSize(100, 30).setLabel("Exercise Test 3").activateBy(ControlP5.RELEASE);
  NotificationComparator priorityComp = new NotificationComparator();
  q2 = new PriorityQueue<Notification>(10, priorityComp);
  server = new NotificationServer();
  example = new Example();
  server.addListener(example);
  ac.start();
}

public void swipeLeft() {
   bodyPosition = "swipeLeft";
   sumSawsGain.clearInputConnections();
   sumSinesGain.clearInputConnections();
   sumSawsGain.addInput(sawLeftGain);
   sumSinesGain.addInput(sineLeftGain);
}

public void swipeRight() {
   bodyPosition = "swipeRight";
   sumSawsGain.clearInputConnections();
   sumSinesGain.clearInputConnections();
   sumSawsGain.addInput(sawRightGain);
   sumSinesGain.addInput(sineRightGain);
}

public void swipeUp() {
   bodyPosition = "swipeUp";
   sumSawsGain.clearInputConnections();
   sumSinesGain.clearInputConnections();
   sumSawsGain.addInput(sawUpGain);
   sumSinesGain.addInput(sineUpGain);
}

public void swipeDown() {
   bodyPosition = "swipeDown";
   sumSawsGain.clearInputConnections();
   sumSinesGain.clearInputConnections();
   sumSawsGain.addInput(sawDownGain);
   sumSinesGain.addInput(sineDownGain);
}


void ttsExamplePlayback(String inputSpeech) {
  String ttsFilePath = ttsMaker.createTTSWavFile(inputSpeech);
  println("File created at " + ttsFilePath);
  SamplePlayer sp = getSamplePlayer(ttsFilePath, true); 
  ac.out.addInput(sp);
  sp.setToLoopStart();
  sp.start();
  println("TTS: " + inputSpeech);
}

public void bodyAngle() {
   ttsExamplePlayback(bodyPosition); 
}


public void exercise1() {
   ac.start();
   showVid = true;
   rehabVid.jump(0);
   rehabVid.play();
   server.loadEventStream(exercise1Json);
   gainEnvelope.addSegment(1, 0);
   gainEnvelope.addSegment(0, 12000);
}

public void exercise2() {
   ac.start();
   showVid = true;
   rehabVid.jump(0);
   rehabVid.play();
   server.loadEventStream(exercise2Json);
   gainEnvelope.addSegment(1, 0);
   gainEnvelope.addSegment(0, 12000);
}

public void exercise3() {
   ac.start();
   showVid = true;
   rehabVid.jump(0);
   rehabVid.play();
   server.loadEventStream(exercise3Json);
   gainEnvelope.addSegment(1, 0);
   gainEnvelope.addSegment(0, 12000);
}


public void align() {
   align.start(0); 
}


public void saxophone() {
   align.pause(false);
   align = getSamplePlayer("saxophone.wav");
   ac.out.addInput(align);
   reverb = new Reverb(ac);
   filter = new BiquadFilter(ac, BiquadFilter.LP, 1500.0, 0.5f);
   filter.addInput(align);
   masterGain.addInput(filter);
   align.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
   align.start(0);
}


public void pan() {
   if (panner == LEFT) {
     panner = RIGHT;
   } else {
     panner = LEFT; 
   }
   p.setPos(panner);
}

public void xyGrid() {
   float x = xyGrid.getArrayValue()[0]; 
   float y = xyGrid.getArrayValue()[1];   
  
   p.setPos(x);
   if (y <= 1 && y >= -1) {
      modulatorGain.clearInputConnections();
      g.clearInputConnections();
      g.addInput(sumSinesGain);
      g.addInput(sumSawsGain);
      g.addInput(alignmentGain);
   } else {
      g.clearInputConnections();
      modulatorGain.clearInputConnections();
      modulatorGain.addInput(sumSinesGain);
      modulatorGain.addInput(sumSawsGain);
      g.addInput(modulatorGain);
      g.addInput(alignmentGain);
      modulator.setFrequency(y);
   }
}

public void GainSlider(float value) {
  gainGlide.setValue(value/100.0);
}

public void leftSlider(float value) {
  sawLeftGlide.setValue(value/100.0);
  sineLeftGlide.setValue(1-(value/100.0));
}

public void rightSlider(float value) {
  sawRightGlide.setValue(value/100.0);
  sineRightGlide.setValue(1-(value/100.0));
}

public void upSlider(float value) {
  sawUpGlide.setValue(value/100.0);
  sineUpGlide.setValue(1-(value/100.0));
}

public void downSlider(float value) {
  sawDownGlide.setValue(value/100.0);
  sineDownGlide.setValue(1-(value/100.0));
}


public void alignmentSlider(float value) {
  alignmentGlide.setValue(value/100.0);
}

void movieEvent(Movie movie) {
   movie.read(); 
}

void draw() {
   background(0);
   if (showVid) { image(rehabVid, 0, 0); }
}
