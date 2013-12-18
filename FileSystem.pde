import java.util.*;

public class FileSystem {
  
  // root path for current snapshot
  private String path;

  // List<FileItem>
  private List<FileItem> content;

  public FileSystem(String _path) {
    this.path = _path;
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

  public ArrayList ketaiList(){
    ArrayList<String> result = new ArrayList<String>();
    for(FileItem item : content){
      if(item.getType().equals("DIR")){
        result.add(item.getPath());
      }
      if(item.getType().equals("FILE")){
        result.add(item.getName());
      }
    }
    return result;
  }
  
  public FileItem find(String path){
    for(FileItem item : content){
      if(item.getPath().equals(path)){
        return item;
      }
    }
    return null;
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

