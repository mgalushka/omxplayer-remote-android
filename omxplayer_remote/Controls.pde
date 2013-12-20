import java.util.*;

public class Control {

  private PApplet applet;

  public Control(PApplet _applet) {
    this.applet = _applet;
  }

  public void draw() {
  }
  public void keyPressed() {
  }
}

public class PlayControl extends Control {

  public PlayControl(PApplet _applet) {
    super(_applet);
  }
}

