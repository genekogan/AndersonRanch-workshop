import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(720, 540);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 8000);
}

void draw() {

}

void keyPressed() {
  if (key==' ') {
    sendOsc();
  }
}

void sendOsc() {
  OscMessage msg = new OscMessage("/classification");
  msg.add(1);
  oscP5.send(msg, myRemoteLocation);
}

void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage);
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
} 
  