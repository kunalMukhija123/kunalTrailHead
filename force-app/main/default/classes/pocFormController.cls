public class pocFormController {
    public String firstName {get;set;}
    public String lastName {get;set;}
    public String email {get;set;}
    
    public pocFormController(){
        firstName = '';
        lastName = '';
        email = '';
    }
    
    public pageReference saveForm(){
        return null;
    }
}