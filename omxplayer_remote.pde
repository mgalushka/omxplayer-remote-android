import ketai.camera.*;
import ketai.net.nfc.record.*;
import ketai.net.*;
import ketai.ui.*;
import ketai.cv.facedetector.*;
import ketai.sensors.*;
import ketai.net.nfc.*;
import ketai.net.wifidirect.*;
import ketai.data.*;
import ketai.net.bluetooth.*;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

import com.google.gson.Gson;

RemoteControl remote;

// list of filesystem objects
KetaiList filesystemList;

// object that contains current snapshot of browsed directory
FileSystem fileSystem;

String DEFAULT_BROWSE_ROOT = "/";

void setup() {
  try
  {
    remote = new RemoteControl();
    remote.init();

    // TODO: persist this betwwen application runs
    fileSystem = remote.browse(DEFAULT_BROWSE_ROOT);  
    filesystemList = new KetaiList(this, fileSystem.ketaiList());

    background(0);  
    rectMode(CENTER);
  } 
  catch( Exception e ) { 
    e.printStackTrace();
  }
}



void draw() {
  background(255);
  fill(0);
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
  if (item.getType().equals("DIR")) {
    print("going deeper level to: " + item.getPath());
    fileSystem = remote.browse(item.getPath());  
    filesystemList = new KetaiList(this, fileSystem.ketaiList());
  }
  if (item.getType().equals("FILE")) {
    print("Open file for playing in omxplayer: " + item.getPath());
  }
}

void mousePressed() {
}

void exit() {
  if (remote != null) {
    remote.clear();
  }
}

