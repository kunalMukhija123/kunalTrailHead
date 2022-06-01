global class batchToProcessStage implements Database.Batchable<sObject>{
    
    global Database.queryLocator Start(Database.BatchableContext BC){
     string query = 'SELECT Id , Orgganization_Name__c , First_Name__c , Last_Name__c , Individual_or_Organization__c , Date_Recieved__c , Postal_Code__c , Amount__c , Description__c , Error_Message__c FROM Staging__c';
     return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext Bc, List<sObject> scope){
     set<string> F_Name = new set<string>();
     set<string> L_Name = new set<string>();
     set<string> P_code = new set<string>();
     set<string> PostCode = new set<string>();
     set<string> Org_Name = new set<string>();
     
     string stgKey;
     string stgKey_acc;
     string stgKey_con;
       
     List<contact> conList = new List<contact>();
     List<account> accList = new List<account>();  
     List<contact> NewconList = new List<contact>();
     List<account> NewaccList = new List<account>();
     List<opportunity> NewOppList = new List<opportunity>();
     Map<string , contact> conMap = new Map<string , contact>();
     Map<string , contact> conMapNew = new Map<string , contact>();
     Map<string , account> accMap = new Map<string , account>(); 
     
 /*  for(sObject s : scope){
         Staging__c stg = (Staging__c)s;
         F_Name.add(stg.First_Name__c);
         L_Name.add(stg.Last_Name__c);
         P_code.add(stg.Postal_Code__c);
         Org_Name.add(stg.Orgganization_Name__c);  
     }

     conList = [SELECT Id , Name , FirstName , LastName , mailingPostalCode FROM Contact where FirstName IN: F_Name AND LastName IN: L_Name AND mailingPostalCode IN: P_code];
     for(contact con : conList){
         string conKey = con.FirstName + con.LastName + con.mailingPostalCode;
         conMap.put(conkey , con);
         system.debug('------conMap------' +conMap);
     }
     
     accList = [SELECT Id , Name , AccountNumber , Industry , billingPostalCode FROM account where Name IN: Org_Name AND billingPostalCode IN: P_code];
     for(account acc : accList){
         string accKey = acc.Name + acc.billingPostalCode;
         accMap.put(accKey , acc);
         system.debug('------AccMap------' +AccMap);
     }    */
     
     
         for(sObject s : scope){
             Staging__c stg = (Staging__c)s;
             if(stg.Individual_or_Organization__c == 1){
                 F_Name.add(stg.First_Name__c);
                 L_Name.add(stg.Last_Name__c);
                 P_code.add(stg.Postal_Code__c);
             }else{
                 Org_Name.add(stg.Orgganization_Name__c); 
                 PostCode.add(stg.Postal_Code__c);
             }
         }
         
         conList = [SELECT Id , Name , FirstName , LastName , mailingPostalCode FROM Contact where FirstName IN: F_Name AND LastName IN: L_Name AND mailingPostalCode IN: P_code];
         system.debug('-----conList data---' +conList);
         accList = [SELECT Id , Name , AccountNumber , Industry , billingPostalCode FROM account where Name IN: Org_Name AND billingPostalCode IN: PostCode];
         system.debug('-----acc List data---' +accList);
         
         for(sObject s : scope){
             Staging__c stg = (Staging__c)s;
             
             if(conList.size() > 0){
                 system.debug('------size of List----- ' +conList.size());
                 system.debug('------No need of new contact------');
             }else{
                 contact con = new contact();
                 con.FirstName = stg.First_Name__c;
                 con.LastName = stg.Last_Name__c;
                 con.mailingPostalCode = stg.Postal_Code__c;
                 NewconList.add(con);
                 system.debug('----New con List data---- ' +NewconList);
             }
             
             if(accList.size() > 0){
                 system.debug('------No need of new account------');
             }else{
                 account acc = new account();
                 acc.Name = stg.Orgganization_Name__c;
                 NewaccList.add(acc);
             }
         }
         insert NewconList;
         insert NewaccList;
         
         system.debug('----New con List data---- ' +NewconList);
         List<account> updatedAccList = new List<account>([SELECT Id , Name , AccountNumber , Industry , billingPostalCode FROM account where Name IN: Org_Name AND billingPostalCode IN: PostCode]);
         List<contact> updatedConList = new List<contact>([SELECT Id , Name , FirstName , LastName , mailingPostalCode FROM Contact where FirstName IN: F_Name AND LastName IN: L_Name AND mailingPostalCode IN: P_code]);
         
         for(sObject s : scope){
             Staging__c stg = (Staging__c)s;
             if(stg.Orgganization_Name__c != null && stg.Postal_Code__c != null){
                 for(account ac : updatedAccList){
                     for(contact co : updatedConList){
                         co.AccountId = ac.Id;
                     }
                 }
             }  
             
             if(stg.Last_Name__c != null && stg.Postal_Code__c != null){
                 for(contact co : updatedConList){
                     for(account ac : updatedAccList){
                         if(co.Name == ac.Name){
                             ac.Id = co.accountId;
                         }
                     }
                 }
             }
         }  
         update updatedConList;
         update updatedAccList;
    }
         
    
    
    global void finish(Database.BatchableContext BC){
        
    }    
}