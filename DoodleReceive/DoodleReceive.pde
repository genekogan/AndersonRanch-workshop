import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

String m="";

void setup() {
  size(720, 540);
  oscP5 = new OscP5(this, 8000);
}

void draw() {
  background(0);
  fill(255);
  textSize(20);
  text(m, 50, 50);
}

void keyPressed() {
}


void oscEvent(OscMessage msg) {
  if (msg.addrPattern().equals("/classification")) {
    int n = msg.typetag().length();
    for (int i=0; i<n; i++) {
      
      println(msg.get(i));
      m = msg.get(i).stringValue();
    }
  }
}