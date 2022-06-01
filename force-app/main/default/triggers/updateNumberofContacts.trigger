trigger updateNumberofContacts on Contact (after insert) {

    Map<string , List<string>> accContactMap = new Map<string , List<string>>();
    set<string> acc = new set<string>();
    List<string> conList = new List<string>();
    
    for(contact con : trigger.new){
        acc.add(con.AccountId);
        system.debug('-----acc set data----- ' +acc);
    }
    
    for(string a : acc){
        for(contact c : trigger.new){
            if(a == c.AccountId){
                conList.add(c.Id);
            }
            system.debug('-------conList data---- ' +conList);
        }
        accContactMap.put(a , conList);
        system.debug('------Map Data----- ' +accContactMap);
    }
   
    List<Account> accObj = new List<Account>();
    for(Account a : [SELECT Id , Name , Number_of_Contacts__c FROM Account Where ID IN : accContactMap.keyset()]){
        if(a.Number_of_Contacts__c > 0){            
            a.Number_of_Contacts__c += (accContactMap.get(a.id)).size();
            system.debug('----size -- ' +accContactMap.get(a.id));
            system.debug('----size -- ' +(accContactMap.get(a.id)).size());
            accObj.add(a);  
        }else{
            a.Number_of_Contacts__c = 1;
            accObj.add(a);  
        }   
    }
    update accObj;
}