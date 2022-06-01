public class contactTriggerHandler {
     public static void UpdateAccount(List<Contact> conList){
        Set<id> conAccIds = new Set<Id>(); 
        
        for(Contact Con : conList) {   
            if(Con.AccountId!= null) {
                if(!conAccIds.contains(Con.AccountId))
                 conAccIds.add(Con.AccountId); 
                 system.debug('--------conAccIds----- ' +conAccIds);
            }
        } 
        
        if(conAccIds.size() > 0) {
            
        List<Account> accList = [SELECT Id, LastUpdatedcontact__c , (select id from contacts order by LastModifiedDate desc limit 1) FROM Account WHERE Id IN : conAccIds ];
            for(Account acc : accList) {
                acc.LastUpdatedContact__c = acc.contacts.get(0).id;
                system.debug('-----acc.LastUpdatedContact__c----- ' +acc.LastUpdatedContact__c);
            }
            update accList; 
        }
    }

}