trigger CopyAccField on Account (after insert , after update ) {
Set<String> AccIdSet = new Set<String>();
for(Account a : trigger.new)
             {
                AccIdSet.add(a.Id);
             }   
             
List<contact> ContactList = [select Id ,accountId, phone from contact WHERE AccountId IN : AccIdSet ];
Map<Id,List<contact>> AccContactMap = new Map<Id,List<contact>>();
     for(contact c : ContactList)
         {
         if(AccContactMap.containskey(c.AccountId)) {
         List<Contact> ConList = AccContactMap.get(c.AccountId);
         ConList.add(c);
         AccContactMap.put(c.AccountId, ConList);
                 }
         else
         {
         List<contact> ConList = new List<contact>();
         ConList.add(c);
         AccContactMap.put(c.AccountId,ConList);
         
         }
     }
     
     List<Contact> listtoUpdate = new List<Contact>() ;
     for(Account acc:Trigger.new){
       if(AccContactMap.containsKey(acc.ID)){
            List<Contact> conList = AccContactMap.get(acc.ID);
            for(Contact con:conList){
               con.Phone = acc.Phone ;
               listtoUpdate.add(con) ;
            } 
            
            }
     }
      
      if(listtoUpdate.isEmpty() == false){
           update listtoUpdate  ;
      }
     
}