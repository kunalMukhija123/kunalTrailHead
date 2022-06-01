public class mass_Delete{

    public List<SObject> rec{get;set;}
    public String returnUrl;
    
    public mass_Delete(ApexPages.StandardSetController controller){
        rec = (List<SObject>)controller.getSelected();
        ApexPages.addmessage(new Apexpages.message(Apexpages.severity.info,'List Of objects'+rec));
    }
    
    public pageReference deleteRecord(){
        delete rec;
     // returnUrl = ApexPages.currentPage().getParameters.get('retUrl');
        
        pageReference pageref = new pageReference('/'+returnUrl);
        pageRef.setRedirect(true);
        return pageRef;     
    }
}