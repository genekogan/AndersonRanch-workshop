import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
int myClass;

void setup() {
  size(500, 500);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 6448);
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