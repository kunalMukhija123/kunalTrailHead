global class batchToProcessStg_InsOpp implements Database.Batchable<sObject>{
    
    global Database.queryLocator Start(Database.BatchableContext BC){
     string query = 'SELECT Id , Orgganization_Name__c , First_Name__c , Last_Name__c , Individual_or_Organization__c , Date_Recieved__c , Postal_Code__c , Amount__c , Description__c , Error_Message__c FROM Staging__c';
     return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext Bc, List<sObject> scope){
     set<string> F_Name = new set<string>();
     set<string> L_Name = new set<string>();
     set<string> P_code = new set<string>();
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
     
     for(sObject s : scope){
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
     }
     
     
     for(sObject s : scope){
         Staging__c stg = (Staging__c)s;
         stgKey = stg.First_Name__c + stg.Last_Name__c + stg.Postal_Code__c ;
         stgKey_acc = stg.Orgganization_Name__c + stg.Postal_Code__c;
         stgKey_con = stg.Last_Name__c + stg.Postal_Code__c;
         
         if(stg.Individual_or_Organization__c == 1){
             system.debug('---------stgKey value----- ' +stgKey);
                 if(conMap.get(stgKey) != null){
                     system.debug('-----No need of new contact-----');
                 }else{
                     system.debug('--- Need to create-------');
                     contact con = new contact();
                     con.FirstName = stg.First_Name__c;
                     system.debug('-------contact first  Name ---  ' +stg.First_Name__c +'-----------' +con.FirstName);
                     con.LastName = stg.Last_Name__c;
                     con.mailingPostalCode = stg.Postal_Code__c;
                     NewconList.add(con);
                     system.debug('------New Con List Data------  '+NewconList);
                 }
                 system.debug('------New Con List Data------  '+NewconList);
          
                 if(stg.Orgganization_Name__c != null && stg.Postal_Code__c != null){
                 system.debug('----------70-----' +stgKey_acc);
                 system.debug('--------71====' +accMap.get(stgKey_acc));
                     if(accMap.get(stgKey_acc) != null){
                     system.debug('-----already');
                         for(contact c : NewconList){
                            system.debug('------c data----' +c);
                                                                                                                                
                             if(accMap.get(stgKey_acc).Name == c.Name ){
                                 c.AccountId = accMap.get(stgKey_acc).Id;
                             }
                         }  
                     }     
                 }    
         }else{
                 system.debug('-------else case-----');
                 system.debug('----------70-----' +stgKey_acc);
                 system.debug('--------71====' +accMap.get(stgKey_acc));
                 if(AccMap.get(stgKey_acc) != null){
                     system.debug('-----No need of new account-----');
                 }else{
                     Account acc = new Account();
                     system.debug('-------new acc------91-----');
                     acc.Name = stg.First_Name__c + stg.Last_Name__c ;
                     acc.billingPostalCode = stg.Postal_Code__c;
                     system.debug('------new acc---- 94 ----' +acc);
                     NewaccList.add(acc);
                     system.debug('--------New acc List---- ' +NewaccList);
                 }
             
               if(stg.Last_Name__c != null && stg.Postal_Code__c != null){
                 system.debug('---------100--------'+conMap.get(stgKey));
                 system.debug('---------101--------'+stgKey);
                 if(conMap.get(stgKey) != null){
                     system.debug('---------102--------'+NewaccList);
                     for(account ac : NewaccList){
                         
                         if(conMap.get(stgKey).Name == ac.Name){
                            
                            conMap.get(stgKey).AccountId = ac.Id;
                            system.debug('----------Not Matched---------109------');        
                            opportunity opp = new opportunity();
                            opp.Name = ac.Name + stg.Date_Recieved__c;
                            opp.CloseDate = stg.Date_Recieved__c;
                            opp.Amount = stg.Amount__c;
                            opp.Description = stg.Description__c;
                            system.debug('----------Not Matched---------115------' +opp);
                            NewOppList.add(opp);
                            system.debug('----------Not Matched---------117------' +NewOppList);
                         }
                     }
                 }else{
                     system.debug('----------Not Matched---------119------');
                 }
             }       
         }
     }
     
     if(NewconList.size() > 0){
         insert NewconList;
      // NewconList.clear();
     }
     
     if(NewaccList.size() > 0){
         insert NewaccList;
      // NewaccList.clear();
     }
     
     if(NewOppList.size() > 0){
         insert NewOppList;
     //  NewOppList.clear();
     }

    }
    
    global void finish(Database.BatchableContext BC){
        
    }    
}