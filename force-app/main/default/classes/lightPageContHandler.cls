public class lightPageContHandler{
    
    public boolean Show_hide {get; set;}
    public contact con {get; set;}
    public string FirstName {get ; set;}
    public string LastName {get ; set;}
        
    public lightPageContHandler(){
        Show_hide = false;
    }
    
    public void showModal(){
        Show_hide = true;
    }
    
    public void cancel(){
        Show_hide = false;
        system.debug('-----show_hide---- ' +show_hide);
    }
    
    public void saveCon(){
        con = new contact();
        
        system.debug('-----first Name---- ' +FirstName +'-----' +con.FirstName);
        system.debug('-----first Name---- ' +LastName +'-----'+con.LastName);
        
        con.FirstName = FirstName;  
        con.LastName = LastName;
        insert con; 
        Show_hide = false;   
    }
}