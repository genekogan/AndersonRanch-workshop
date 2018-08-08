import oscP5.*;
import netP5.*;
import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

OscP5 oscP5;
NetAddress myRemoteLocation;
int myClass;
Capture cam;
OpenCV opencv;
Rectangle[] faces;

void setup() {
  size(720, 540);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 6448);
  cam = new Capture(this, 640, 480);
  cam.start();
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw() {
  sendOsc();
  if (myClass==1) {
    background(255, 0, 0);
  }
  else if (myClass==2) {
    background(0, 255, 0);
  }
  else if (myClass==3) {
    background(0, 0, 255);
  }
  
  if (cam.available() == true) {
    cam.read();
  }
  opencv.loadImage(cam);
  faces = opencv.detect();
  image(opencv.getInput(), 0, 0);
  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }


}

void keyPressed() {
  if (key==' ') {
    sendOsc();
  }
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add(float(mouseX));
  msg.add(float(mouseY));
  oscP5.send(msg, myRemoteLocation);
}

void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage);
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  
  int c = int(theOscMessage.get(0).floatValue());
  myClass = c;
}