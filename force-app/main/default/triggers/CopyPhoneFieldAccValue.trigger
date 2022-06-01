trigger CopyPhoneFieldAccValue on Contact (before insert , before update) {
Set<id> AccId = new set<id>();
for(Contact con : trigger.new)
{
AccId.add(con.AccountId);
System.debug('-------accc111-----'+AccId);
}
List<contact> ConList = [Select id, phone , account.phone from Contact WHERE AccountId IN: AccId];
System.debug('-------ConList -----'+ConList );
for(Contact C : ConList){
C.phone = C.Account.Phone;
System.debug('-------C.phone -----'+C.phone);
}
}