import ketai.net.*;
import ketai.ui.*;
import ketai.data.*;

import org.apache.http.*;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

import com.google.gson.Gson;

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
    filesystemList = new KetaiList(this, fileSystem.ketaiList());
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

