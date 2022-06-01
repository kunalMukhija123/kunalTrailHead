public with sharing class passingLookupIdController {
    public Contact con{get;set;}
     public Account account{get;set;}
    public passingLookupIdController (){
        con =  new Contact();        
    }
    public PageReference PassingParameter(){
        Id recordId = ApexPages.currentPage().getParameters().get('recordId');
        System.debug('Print--->'+recordId );
        account = [SELECT ID,Industry FROM Account WHERE id=:recordId ];  
        return null;  
    } 
}