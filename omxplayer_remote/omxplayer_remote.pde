import ketai.net.*;
import ketai.ui.*;
import ketai.data.*;

import apwidgets.*;

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

APWidgetContainer widgets; 
// remount button
APButton remountBtn;

// object that contains current snapshot of browsed directory
AsyncTask<Command, Void, FileSystem> fileSystemAsync;
FileSystem fileSystem;

String DEFAULT_BROWSE_ROOT = "/media";

// flag shows if we are in playing mode for film
// should be persistable bewteen apllication runs/or retrievable from raspberry service rest call
boolean playingMode = false;

void setup() {
  W = width;
  H = height;

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

  widgets = new APWidgetContainer(this);
  remountBtn = new APButton(32, W-32, H-75, 75, "Remount");

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
    
    widgets.show();

    // draw playing controls here
    background(255);
    fill(0);

    imageMode(CENTER);

    playControl.draw();
    stopControl.draw();
    seekForward.draw();
    seekBackward.draw();
    seekMoreForward.draw();
    seekMoreBackward.draw();
  }
  else {
    widgets.hide();
    background(0);  
    rectMode(CENTER);
  }
}

void keyPressed() {
  if (playingMode) {
    // sound controls
    if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_DOWN) {
      println ("Volume down");
      remote = new RemoteControl();
      remote.execute(new Command("voldown"));
    }
    if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_UP) {
      println ("Volume up");
      remote = new RemoteControl();
      remote.execute(new Command("volup"));
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

    remote = new RemoteControl();
    remote.execute(new Command("play", item.getPath()));

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

    if (stopControl.isStopped()) {
      playingMode = false;

      try {
        remote = new RemoteControl();
        // TODO: persist latest browsed path between application runs
        fileSystemAsync = browser.execute(new Command("browse", DEFAULT_BROWSE_ROOT)); 
        fileSystem = fileSystemAsync.get();
        filesystemList = new KetaiList(this, fileSystem.ketaiList());
      } 
      catch(Exception ex) {
        print(ex);
      }
    }
  }
}

//onClickWidget is called when a widget is clicked/touched
void onClickWidget(APWidget widget) {
  if (widget == remountBtn) { 
    remote = new RemoteControl();
    remote.execute(new Command("remount"));
  }
}

void exit() {
  if (remote != null) {
  }
}

