import ketai.net.*;
import ketai.ui.*;
import ketai.data.*;

import org.apache.http.*;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.entity.*;
import org.apache.http.params.*;
import org.apache.http.util.*;

import android.os.AsyncTask;

import com.maximgalushka.omxremote.model.*;
import com.maximgalushka.omxremote.service.*;

import com.google.gson.Gson;

int W, H;

PImage SPEAKER;
PImage MUTED;

PImage PLAY;
PImage PAUSE;
PImage STOP;

PImage REWIND_LEFT;
PImage REWIND_MORE_LEFT;
PImage REWIND_RIGHT;
PImage REWIND_MORE_RIGHT;

PlayControl playControl;
StopControl stopControl;

NoStateControl seekForward;
NoStateControl seekMoreForward;
NoStateControl seekBackward;
NoStateControl seekMoreBackward;


FsBrowserControl browser;
RemoteControl remote;

// list of filesystem objects
KetaiList filesystemList;

// object that contains current snapshot of browsed directory
AsyncTask<Command, Void, FileSystem> fileSystemAsync;
FileSystem fileSystem;

String DEFAULT_BROWSE_ROOT = "/";

// flag shows if we are in playing mode for film
// should be persistable bewteen apllication runs/or retrievable from raspberry service rest call
boolean playingMode = false;

void setup() {
  W = width;
  H = height;

  SPEAKER = loadImage("speaker.png");
  MUTED = loadImage("muted.png");

  PLAY = loadImage("play.png");
  PAUSE = loadImage("pause.png");
  STOP = loadImage("stop.png");

  REWIND_LEFT = loadImage("rewind_left.png");
  REWIND_MORE_LEFT = loadImage("rewind_more_left.png");
  REWIND_RIGHT = loadImage("rewind_right.png");
  REWIND_MORE_RIGHT = loadImage("rewind_more_right.png");

  playControl = new PlayControl(this);
  stopControl = new StopControl(this);

  seekForward = new NoStateControl(this, "rewind_right.png", W - 8*32, 3*32, "seek30");
  seekBackward = new NoStateControl(this, "rewind_left.png", 8*32, 3*32, "seek-30");
  seekMoreForward = new NoStateControl(this, "rewind_more_right.png", W - 3*32, 3*32, "seek600");
  seekMoreBackward = new NoStateControl(this, "rewind_more_left.png", 3*32, 3*32, "seek-600");


  playControl.setup();
  stopControl.setup();
  seekForward.setup();
  seekBackward.setup();
  seekMoreForward.setup();
  seekMoreBackward.setup();

  try
  {    
    browser = new FsBrowserControl();
    remote = new RemoteControl();


    // TODO: persist latest browsed path between application runs
    fileSystemAsync = browser.execute(new Command("browse", DEFAULT_BROWSE_ROOT)); 
    fileSystem = fileSystemAsync.get();
    filesystemList = new KetaiList(this, fileSystem.ketaiList());

    background(0);  
    rectMode(CENTER);
  } 
  catch(Exception e) { 
    e.printStackTrace();
  }
}

void draw() {
  if (playingMode) {
    // draw playing controls here
    background(255);
    fill(0);

    imageMode(CENTER);
    //image(PLAY, W/2, H/2 + 64);
    
    playControl.draw();
    stopControl.draw();
    seekForward.draw();
    seekBackward.draw();
    seekMoreForward.draw();
    seekMoreBackward.draw();

    /*
    image(STOP, W - 3*32, H - 3*32);
     
     image(REWIND_MORE_LEFT, W - 3*32, 3*32);
     image(REWIND_LEFT, W - 8*32, 3*32);
     
     image(REWIND_MORE_RIGHT, 3*32, 3*32);
     image(REWIND_RIGHT, 8*32, 3*32);
     
     image(SPEAKER, W - 3*32, 8*32);
     */
  }
}

void keyPressed() {

  if (playingMode) {
    // sound controls
    if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_DOWN) {
      println ("Volume down");
      remote = new RemoteControl();
      remote.execute(new Command("volup"));
    }
    if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_UP) {
      println ("Volume up");
      remote = new RemoteControl();
      remote.execute(new Command("voldown"));
    }
  }
}

void onKetaiListSelection(KetaiList klist)
{

  String path = klist.getSelection();
  println("Selected path: " + path);

  FileItem item = fileSystem.find(path);
  println("Found path item: " + item);

  if ("DIR".equals(item.getType())) {
    print("going deeper level to: " + item.getPath());

    try {
      browser = new FsBrowserControl();
      fileSystemAsync = browser.execute(new Command("browse", item.getPath()));  
      fileSystem = fileSystemAsync.get();
      filesystemList = new KetaiList(this, fileSystem.ketaiList());
    } 
    catch(Exception ex) {
      print(ex);
    }
  }
  if ("FILE".equals(item.getType())) {
    print("Open file for playing in omxplayer: " + item.getPath());

    // open menu for remote controlling film
    filesystemList = null;
    playingMode = true;
  }
}

void mousePressed() {
  if (playingMode) {
    // count click point and action accordingly
    print("Clicked menu: [" + mouseX + ", " + mouseY + "]");

    playControl.mousePressed();
    stopControl.mousePressed();
    seekForward.mousePressed();
    seekBackward.mousePressed();
    seekMoreForward.mousePressed();
    seekMoreBackward.mousePressed();
  }
}

void exit() {
  if (remote != null) {
  }
}

