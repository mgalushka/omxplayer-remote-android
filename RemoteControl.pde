import java.util.*;

public class RemoteControl {

  private DefaultHttpClient httpClient;
  private String ROOT = "http://192.168.1.103/omx/command.php";

  public void init() {
    httpClient = new DefaultHttpClient();
  }

  public void clear() {
    httpClient = null;
  }

  public void execute(Action action) {
  }

  public FileSystem browse(String path) {
    // TODO: this is stub
    // TODO: in case of delays from rest service - implement timeout action
    // propose the user to remount/reboot raspberry device 
    FileSystem result = new FileSystem("/media");

    FileItem dir = new FileItem("/media/films", "files", "DIR");
    FileItem file = new FileItem("/media/films/1.avi", "1.avi", "FILE");

    List<FileItem> items = new ArrayList<FileItem>();
    items.add(dir);
    items.add(file);

    result.setContent(items);
    return result; //new ArrayList(Arrays.asList("/media/films", "/media/video"));
  }

  public void browseCall(String path) {
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


  public void sendToServer(Command command) {
    try {
      println("Execute command: " + command);

      Gson gson = new Gson(); // Or use new GsonBuilder().create();
      //gson.
      String json = "";

      HttpPost httpPost   = new HttpPost(ROOT);
      httpPost.setRequestEntity(new StringRequestEntity(json));      

      HttpResponse response = httpClient.execute( httpPost );
      HttpEntity   entity   = response.getEntity();

      Gson gson = new Gson(); // Or use new GsonBuilder().create();

      String json = EntityUtils.toString(entity);
      println ("json = " + json);

      FileSystem fs = gson.fromJson(json, FileSystem.class);

      println (fs);
    } 
    catch (IOException io) {
      io.printStackTrace();
    }
  }

  public void _sendToServer(String command) {
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

