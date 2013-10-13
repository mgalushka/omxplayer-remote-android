void setup() {
 
  
  background(0);  
  rectMode(CENTER);
}


void draw() {
  background(255);
  fill(0);

}

 void keyPressed() {
    if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_DOWN) {
      println ("Volume down");    
    }
    if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_UP) {
      println ("Volume up");    
    }
  }

