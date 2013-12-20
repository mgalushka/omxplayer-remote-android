import java.util.*;

public class Command {
  
  public final Command PAUSE_COMMAND = new Command("pause");
  public final Command STOP_COMMAND = new Command("stop");
  public final Command VOLUP_COMMAND = new Command("volup");
  public final Command VOLDOWN_COMMAND = new Command("voldown");
  
  private String request;
  private String path;
  
  public Command() {
  }
  
  public Command(String _request) {
    this.request = _request;
  }

  public Command(String _request, String _path) {
    this.request = _request;
    this.path = _path;
  }

  public String getRequest() {
    return this.request;
  }

  public String getPath() {
    return this.path;
  }

  public String toString() {
    return "{request = " + this.request + ", path = " + this.path + "}";
  }
}

