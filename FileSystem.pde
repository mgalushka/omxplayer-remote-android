import java.util.*;

public class FileSystem{
  private String path;
  private List content;
  
  public FileSystem(){
  }
  
  public String getPath(){
     return path;
  }
   public void setPath(String path){
     this.path = path;
  }
  
  public List getContent(){
     return content;
  }
   public void setContent(List content){
     this.content = content;
  }
  
  public String toString(){
    return "path = [" + path +"], content = [" + content + "]";
  }
}
