public class InputfieldDemoController {

    //Variable under test
    public String valuefromJS {get; set;}
    public String valuefromJS1 {get; set;}
    
    public pagereference someMethod(){
       
        System.debug(valuefromJS);
        system.debug(valuefromJS1);
        
        return null;
    }
}