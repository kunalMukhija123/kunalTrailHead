public class NewAndExistingController {
    Account acc = NEW Account();   
    public PageReference click() { 
        PageReference openvfpage = New Pagereference('/apex'+'/XYZ');
        openvfpage.setRedirect(false);
        return openvfpage ;        
   }   
   public NewAndExistingController() {    }  
}