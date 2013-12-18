import java.util.*;

public class FileSystem {
  private String path;

  // List<FileItem>
  private List content;

  public FileSystem() {
  }

  public String getPath() {
    return path;
  }
  public void setPath(String path) {
    this.path = path;
  }

  public List getContent() {
    return content;
  }
  public void setContent(List content) {
    this.content = content;
  }

  public String toString() {
    return "path = [" + path +"], content = [" + content + "]";
  }
}

public class FileItem {
  private String path;
  private String name;  
  private String type;

  public FileItem(String _path, String _name, String _type) {
    this.path = _path;
    this.name = _name;
    this.type = _type;
  }

  public String getPath() {
    return this.path;
  }

  public String getName() {
    return this.name;
  }

  public String getType() {
    return this.type;
  }
}

