import java.util.*;

public class Control {

  protected PApplet applet;
  protected int W, H;
  protected RemoteControl remote;

  public Control(PApplet _applet) {
    this.applet = _applet;
    this.W = width;
    this.H = height;
  }

  public void setup() {
  }

  public void draw() {
  }

  public void keyPressed() {
  }
}

// play/pause actions
public class PlayControl extends Control {

  private PImage PLAY;
  private PImage PAUSE;
  private boolean playing = true;

  public PlayControl(PApplet _applet) {
    super(_applet);
  }

  public void setup() {
    PLAY = applet.loadImage("play.png");
    PAUSE = applet.loadImage("pause.png");
  }

  public void draw() {
    if (playing) {
      applet.image(PAUSE, W/2, H/2);
    }
    else {
      applet.image(PLAY, W/2, H/2);
    }
  }

  public void mousePressed() {
    int X = applet.mouseX;
    int Y = applet.mouseY;
    print ("dist to center: " + dist(X, Y, W/2, H/2));
    if (dist(X, Y, W/2, H/2) <= 256) {
      playing = !playing;
      remote = new RemoteControl();      
      remote.execute(new Command("pause"));
    }
  }
}

// stop action
public class StopControl extends Control {

  private PImage STOP;
  private boolean stopped = false;

  public StopControl(PApplet _applet) {
    super(_applet);
  }

  public boolean isStopped() {
    return this.stopped;
  }

  public void setup() {
    STOP = applet.loadImage("stop.png");
  }

  public void draw() {
    applet.image(STOP, W - 3*32, H - 3*32);
  }

  public void mousePressed() {
    int X = applet.mouseX;
    int Y = applet.mouseY;
    if (dist(X, Y, W - 3*32, H - 3*32) <= 64) {
      this.stopped = true;
      remote = new RemoteControl();      
      remote.execute(new Command("stop"));
    }
  }
}

// rewind controls
public class NoStateControl extends Control {

  private String image;
  private PImage CONTROL_IMAGE;
  
  // center of control position
  private int cX, cY;
  
  private String command;

  public NoStateControl(PApplet _applet) {
    super(_applet);
  }
  
  public NoStateControl(PApplet _applet, String _image, int x, int y, String _command) {
    this(_applet);
    this.image = image;
    this.cX = x;
    this.cY = y;
    this.command = _command;
  }

  public void setup() {
    CONTROL_IMAGE = applet.loadImage(this.image);
  }

  public void draw() {
    applet.image(CONTROL_IMAGE, cX, cY);
  }

  public void mousePressed() {
    int X = applet.mouseX;
    int Y = applet.mouseY;
    if (dist(X, Y, cX, cY) <= 64) {
      remote = new RemoteControl();      
      remote.execute(new Command(this.command));
    }
  }
}

