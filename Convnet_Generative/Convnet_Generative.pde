import oscP5.*;
import netP5.*;

OscP5 oscP5;
float value;
float nextValue;
float t;

void setup() {
  size(720, 540);
  oscP5 = new OscP5(this, 12000);
  t = 0;
  background(0);
}

void draw() {
  value = lerp(value, nextValue, 0.1);
  
  float x1 = width * noise(t, 5);
  float x2 = width * noise(t, 15);
  float x3 = width * noise(t, 25);
  float x4 = width * noise(t, 35);
  
  float y1 = height * noise(t, 45);
  float y2 = height * noise(t, 55);
  float y3 = height * noise(t, 65);
  float y4 = height * noise(t, 75);
  
  fill(255, 5);
  stroke(100, 30);
  bezier(x1, y1, x2, y2, x3, y3, x4, y4);
  t = t + 0.02 * value;
}

void keyPressed() {
  if (key==' ') {
  }
}

void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage);
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  
  nextValue = theOscMessage.get(0).floatValue();
}