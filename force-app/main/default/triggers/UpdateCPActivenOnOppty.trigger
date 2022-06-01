trigger UpdateCPActivenOnOppty on Customer_Project__c (after insert){
    
    List<Opportunity> oppList = new List<Opportunity>();
    for(Customer_Project__c cp : Trigger.New){
        if(cp.Status__c == 'Active'){
        Opportunity opp= new Opportunity(id=cp.Opportunity__c);
        system.debug('-----opp record data---- ' +opp);
        opp.Active__c = True;
        oppList.add(opp);
        }
    }
    update oppList;
}