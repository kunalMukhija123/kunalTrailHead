trigger TotalAmountForAccount on Contact (after insert, after update , after delete , after undelete ) {

    Set<id> AccIds = new Set<Id>();

    if(Trigger.isUpdate ||  Trigger.isInsert || Trigger.isUnDelete){
        for (contact con : Trigger.new){
            AccIds.add(con.AccountId);
        }
    }

   if(Trigger.isUpdate || Trigger.isDelete ){
        for (contact con : Trigger.old){
            AccIds.add(con.AccountId);
        }
    }   
    
    if (AccIds.size() > 0) {

    Map<id,Account> Accounts = new Map<id,Account>([SELECT id FROM Account WHERE id =: AccIds]);
    for (Account acc : Accounts.values()){
        acc.Total_Amount_Contact__c = 0;
    }
    
    for (Contact con : [SELECT id, Amount__c , AccountId FROM Contact WHERE AccountId =: AccIds]){
        Account acc = Accounts.get(con.AccountId);
        if(con.Amount__c != null) acc.Total_Amount_Contact__c += con.Amount__c;
    }    

    update Accounts.values();
    }
}