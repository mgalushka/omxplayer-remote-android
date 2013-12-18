import ketai.net.*;
import ketai.ui.*;
import ketai.data.*;

import org.apache.http.*;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

import com.google.gson.Gson;

int W,H;

PImage SPEAKER;
PImage MUTED;

PImage PLAY;
PImage PAUSE;
PImage STOP;

PImage REWIND_LEFT;
PImage REWIND_MORE_LEFT;
PImage REWIND_RIGHT;
PImage REWIND_MORE_RIGHT;

RemoteControl remote;

// list of filesystem objects
KetaiList filesystemList;

// object that contains current snapshot of browsed directory
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
  REWIND_RIGHT = loadImage("rewind_left.png");
  REWIND_MORE_RIGHT = loadImage("rewind_more_left.png");
  
  
  try
  {
    remote = new RemoteControl();
    remote.init();

    // TODO: persist latest browsed path between application runs
    fileSystem = remote.browse(DEFAULT_BROWSE_ROOT);  
    filesystemList = new KetaiList(this, fileSystem.ketaiList());

    background(0);  
    rectMode(CENTER);
  } 
  catch(Exception e) { 
    e.printStackTrace();
  }
}

void draw() {
  if(playingMode){
    // draw playing controls here
    background(255);
    fill(0);
    
    imageMode(CENTER);
    image(PLAY, W/2, H/2 + 64);
    image(STOP, W - 3*32, H - 3*32);
    
    image(REWIND_MORE_LEFT, W - 3*32, 3*32);
    image(REWIND_LEFT, W - 8*32, 3*32);
    
    image(REWIND_MORE_RIGHT, 3*32, 3*32);
    image(REWIND_RIGHT, 8*32, 3*32);
    
    image(SPEAKER, W - 3*32, 8*32);
    
  }
}

void keyPressed() {

  // sound controls
  if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_DOWN) {
    println ("Volume down");
    remote.sendToServer("-");
  }
  if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_UP) {
    println ("Volume up");
    remote.sendToServer("+");
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
    fileSystem = remote.browse(item.getPath());  
    filesystemList = new KetaiList(this, fileSystem.ketaiList());
  }
  if ("FILE".equals(item.getType())) {
    print("Open file for playing in omxplayer: " + item.getPath());
    
    // open menu for remote controlling film
    filesystemList = null;
    playingMode = true;
  }
}

void mousePressed() {
  if(playingMode){
    // count click point and action accordingly
    print("Clicked menu: [" + mouseX + ", " + mouseY + "]");
  }
}

void exit() {
  if (remote != null) {
    remote.clear();
  }
}

