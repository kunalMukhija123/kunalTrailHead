public class accAmountHandlerController {

    public static void onAfterInsert(List<Contact> conList) {
        set<Id> accIds = new set<Id>();
        for(contact con : conList){
            accIds.add(con.accountId);
        }  
        
        if (accIds.size() > 0) {

            Map<id,Account> Accounts = new Map<id,Account>([SELECT id FROM Account WHERE id =: accIds]);
            for (Account acc : Accounts.values()){
                acc.Rollup_Amount_X__c = 0;
                acc.Rollup_Amount_Y__c = 0;
                acc.Rollup_Amount__c = 0;
            } 
            
            for (Contact con : [SELECT id, Amount_X__c , Amount_Y__c , Status_Amt__c, AccountId FROM Contact WHERE AccountId =: accIds]){
                Account acc = Accounts.get(con.AccountId);
                if(con.Amount_X__c != null && con.Status_Amt__c == 'Positive' ){
                    acc.Rollup_Amount_X__c += con.Amount_X__c;
                }else if(con.Amount_Y__c != null && con.Status_Amt__c == 'Negative' ){
                    acc.Rollup_Amount_Y__c += con.Amount_Y__c ;
                }
               acc.Rollup_Amount__c = acc.Rollup_Amount_X__c + acc.Rollup_Amount_Y__c ;
            }    
            
            update Accounts.values();
        
        }
    }    
    
    public static void onAfterUpdate(List<Contact> conList) {
        system.debug('-----conList ----- ' +conList);
     //   system.debug('-----conMap------- ' +conMap);
        
        set<Id> accIds = new set<Id>();
        for(contact con : conList){
            accIds.add(con.accountId);
            system.debug('-----acc IDs ---- ' +accIds);
        }  
        
        if (accIds.size() > 0) {
            
            Map<id,Account> Accounts = new Map<id,Account>([SELECT id FROM Account WHERE id =: accIds]);
            for (Account acc : Accounts.values()){
                acc.Rollup_Amount_X__c = 0;
                acc.Rollup_Amount_Y__c = 0;
                acc.Rollup_Amount__c = 0;
            } 
            
            for (Contact con : [SELECT id, Amount_X__c , Amount_Y__c , Status_Amt__c, AccountId FROM Contact WHERE AccountId =: accIds]){
                Account acc = Accounts.get(con.AccountId);
                if(con.Amount_X__c != null && con.Status_Amt__c == 'Positive' ){
                    acc.Rollup_Amount_X__c += con.Amount_X__c;
                }else if(con.Amount_Y__c != null && con.Status_Amt__c == 'Negative' ){
                    acc.Rollup_Amount_Y__c += con.Amount_Y__c ;
                }
               acc.Rollup_Amount__c = acc.Rollup_Amount_X__c + acc.Rollup_Amount_Y__c ;
            }    
            
            update Accounts.values();
        
        }
    }    
}