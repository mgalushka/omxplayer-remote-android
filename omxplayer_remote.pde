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
KetaiList filesystemList;
ArrayList lst = new ArrayList();

void setup() {
  try
  {
    remote = new RemoteControl();
    remote.init();

    lst.add("/media/films");
    lst.add("/media/video");
    filesystemList = new KetaiList(this, lst);

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
  //filesystemList = new KetaiList(this, lst);
}

void keyPressed() {
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
  println("Browse path: " + path);
  remote.browse(path);
}

void mousePressed() {
  try {
    remote.browse("path");
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}

void exit() {
  if (remote != null) {
    remote.clear();
  }
}


