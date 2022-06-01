trigger countNumberofContacts on Contact (after insert) {
    
    set<Id> accountIDs = new set<Id>();
    List<Account> ListofAcc = new List<Account>();
    
    if(Trigger.isInsert || Trigger.isUpdate){
        for(Contact c : trigger.new){
            accountIDs.add(c.AccountId);            
        }
    }    
       
    if(Trigger.isDelete){
        for(Contact c : trigger.old){
            accountIDs.add(c.AccountId);
        }
    }    
    
    ListofAcc = [Select Id , Name , Total_Number_of_contacts__c , (Select id from contacts) from Account Where Id IN : accountIDs ];
    system.debug('-------List of acc------' +ListofAcc);
    
    for(Account acc : ListofAcc){
        acc.Total_Number_of_contacts__c = acc.contacts.size();
        system.debug('-------total number of contacts-----' +acc.Total_Number_of_contacts__c);
    }
    update ListofAcc;
   
    system.debug('-------List of acc------' +ListofAcc);
}