trigger AccountUpdate on Account (before insert , before update) {

set<id> accID = new set<id>();
    for(Account acc : trigger.new){
        accID.add(acc.ownerId);            
    }
    system.debug('-----set contained values---'+accID);
    Map<id,user> usr = new Map<id,user>([Select Name from user where id =: accID]);
    system.debug('-----Map conatined values----'+usr);
    
    for(Account acc : trigger.new){
        User u = usr.get(acc.ownerId);
        acc.Sales_Rep__c = u.Name;
        system.debug('------sales rep - -- - -'+acc.Sales_Rep__c);
    }
    
}