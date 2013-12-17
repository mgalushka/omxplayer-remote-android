import java.util.*;

public class RemoteControl {

  private DefaultHttpClient httpClient;

  //String ROOT = "http://192.168.1.105/omxplayer-web-controls-php/omx_control.php?JsHttpRequest=13816901606273-xml";
  private String ROOT = "http://192.168.1.103/omxplayer-web-controls-php/open.php?path=";

  public void init() {
    httpClient = new DefaultHttpClient();
  }
  
  public void clear() {
    httpClient = null;
  }

  public void execute(Action action) {
  }

  public void browse(String path) {
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


  public void sendToServer(String command) {
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
}

