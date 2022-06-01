trigger copyaccountphone1 on Contact (after insert , after update) {

Set<id> accid = new Set<id>();

Map<Id,string> accmap = new Map<Id,string>();

for(contact con : trigger.new){
 
accid.add(con.AccountId); 
System.debug('----accid----------'+accid);
}

List<Account> acc = [SELECT id , Name , phone from Account WHERE Id IN : accid ];
System.debug('----acc---------'+acc);
for(Account a :acc){
accmap.put(a.id , a.phone);
System.debug('----accmap----------'+accmap);
}

for(Contact con : trigger.new){
//if(accmap.containskey(con.phone)){

con.phone = accmap.get(con.accountId);
System.debug('----phone----------'+con.phone);
//}
}

}