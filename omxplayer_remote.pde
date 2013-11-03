import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

DefaultHttpClient httpClient;
String url = "http://192.168.1.105/omxplayer-web-controls-php/omx_control.php?JsHttpRequest=13816901606273-xml";
HttpPost httpPost;

void setup() {
  try
  {
    httpClient = new DefaultHttpClient();

    httpPost   = new HttpPost( url );
    HttpParams        postParams = new BasicHttpParams();
                      postParams.setParameter( "act", "pause" );
                      postParams.setParameter( "arg", "undefined" ); // Configure the form parameters
                      httpPost.setParams( postParams );    
    
    //println( "executing request: " + httpPost.getRequestLine() );   
    //httpClient.getConnectionManager().shutdown();       
    
  } catch( Exception e ) { e.printStackTrace(); }
  
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

void mousePressed() {
  try{
    HttpResponse response = httpClient.execute( httpPost );
    HttpEntity   entity   = response.getEntity();
        
    println("----------------------------------------");
    println( response.getStatusLine() );
    println("----------------------------------------");
    
    if( entity != null ) entity.writeTo( System.out );
    if( entity != null ) entity.consumeContent();
  } catch (Exception e) {e.printStackTrace();}
}

void sendToServer(){
  
}
