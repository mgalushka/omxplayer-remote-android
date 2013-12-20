public class Action {
  
}

public class BrowseAction extends Action {
  
  private String dir;
    
  protected BrowseAction(String _dir){
    this.dir = _dir;
  }
  
  
}


public class PlayAction extends Action {
}

public class PauseAction extends Action {
}

public class StopAction extends Action {
}

