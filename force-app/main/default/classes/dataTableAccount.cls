public class dataTableAccount{

      public Map<id, Account> accountMap{get;set;}
      public set<ID> AccID {get; set;}
    
    public dataTableAccount(){
        accountMap = new Map<id, Account>();
        for(Account obj : [SELECT Id , Name , AccountNumber FROM account LIMIT 1000]){
                 
           accountMap.put(obj.Id, obj);
           
        }  
        AccID = accountMap.keySet();
        system.debug('-----------------Account Map Data ---------'+accountMap);
        system.debug('---------'+AccID);    
    }
    
   }