Public class mycontrollerextension{

public List<OpportunityLineItem> oppProductList{get;set;}
String oppID;

    private opportunity opp ;
    public myControllerExtension(ApexPages.StandardController stdController){
    opp = [select id , name , stageName , CloseDate from Opportunity where id =:stdController.getID()] ;
    
    oppId=stdController.getId();
    system.debug('-----------------OppId------------:' +oppId);
    oppProductList=new List<OpportunityLineItem>();
     
    }
    public pageReference createBilling(){
    Billing__c b = new Billing__c();
    b.Opportunity_Name__c = opp.Name;
    b.Date__c = opp.CloseDate;
    b.Stage__c = opp.StageName;
    insert b; 
    
    
   oppProductList=[Select id,OpportunityId , Product2Id ,Quantity , UnitPrice , ServiceDate, ProductCode from OpportunityLineItem where OpportunityId =:oppId];
   system.debug('---------------OppProductList-------- : ' +oppProductList );
   for( OpportunityLineItem opp :oppProductList){
           Billing_Line__c a = new Billing_Line__c();
           a.Billing__c = b.Id;
           a.Date__c = opp.ServiceDate ;
           a.Number__c = opp.Quantity;
           a.Price__c =  opp.UnitPrice;
           a.Product__c = opp.ProductCode;
           insert a;
   }
   
    return new PageReference('/'+b.ID);
        
    }    
    
    
  }