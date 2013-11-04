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

DefaultHttpClient httpClient;

//String ROOT = "http://192.168.1.105/omxplayer-web-controls-php/omx_control.php?JsHttpRequest=13816901606273-xml";
String ROOT = "http://192.168.1.103/omxplayer-web-controls-php/open.php?path=";


KetaiList filesystemList;
ArrayList lst = new ArrayList();

void setup() {
  try
  {
    httpClient = new DefaultHttpClient();
    
    lst.add("/media/films");
    lst.add("/media/video");
    filesystemList = new KetaiList(this, lst);
  } 
  catch( Exception e ) { 
    e.printStackTrace();
  }

  background(0);  
  rectMode(CENTER);
}

void exit() {
  if (httpClient != null) {
    //httpClient.getConnectionManager().shutdown();
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
    sendToServer("-");
  }
  if (key == CODED && keyCode == android.view.KeyEvent.KEYCODE_VOLUME_UP) {
    println ("Volume up");
    sendToServer("+");
  }  
}

void onKetaiListSelection(KetaiList klist)
{
  String path = klist.getSelection();  
  println("Browse path: " + path);
  browse(path);
}

void mousePressed() {
  try {
    //sendToServer("pause");
    browse("path");
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}

void browse(String path) {
  try {
    println("Send get request for path: " + ROOT);
    HttpGet httpGet   = new HttpGet(ROOT);

    HttpResponse response = httpClient.execute( httpGet );
    HttpEntity   entity   = response.getEntity();

    println("----------------------------------------");
    println( response.getStatusLine() );
    println("----------------------------------------");

    if ( entity != null ) entity.writeTo( System.out );
    if ( entity != null ) entity.consumeContent();
  } 
  catch (IOException io) {
    io.printStackTrace();
  }
}


void sendToServer(String command) {
  try {
    println("Execute command: " + command);
    HttpPost httpPost   = new HttpPost(ROOT);
    HttpParams postParams = new BasicHttpParams();
    postParams.setParameter( "act", command );
    postParams.setParameter( "arg", "undefined" ); 
    httpPost.setParams( postParams );

    HttpResponse response = httpClient.execute( httpPost );
    HttpEntity   entity   = response.getEntity();
    
    Gson gson = new Gson(); // Or use new GsonBuilder().create();

    println("----------------------------------------");
    println( response.getStatusLine() );
    println("----------------------------------------");

    String json = EntityUtils.toString(entity);
    println ("json = " + json);
    
    FileSystem fs = gson.fromJson(json, FileSystem.class);
    
    println (fs);

    //if ( entity != null ) entity.writeTo( System.out );
    //if ( entity != null ) entity.consumeContent();
  } 
  catch (IOException io) {
    io.printStackTrace();
  }
}

