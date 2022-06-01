trigger RunBatch on Staging__c (after insert , after update) {
 
 List<contact> conList = new List<contact>();
 conList = [SELECT id , Name ,FirstName , LastName , mailingPostalCode FROM Contact];
 Map<id , contact> conMap = new Map<id , contact>(conList); 
 
 List<account> accList = new List<account>();
 accList = [Select id , Name , shippingPostalCode from Account];
 
 List<contact> insert_con =  new List<contact>();
 List<opportunity> insert_opp =  new List<opportunity>();
 //List<account> insert_acc =  new List<account>();
 List<Staging__c> stgList = new List<Staging__c>();
 
 set<string> fName =  new set<string>();
 set<string> lName =  new set<string>();
 set<string> conPostCode =  new set<string>();
 set<string> accPostCode =  new set<string>();
 set<string> AccName = new set<string>();
 set<id> accId = new set<id>();
 set<id> orgId = new set<id>();
 
 for(contact c : conList){
    fName.add(c.FirstName);
    system.debug('-------fName Data----- ' +fName);
    lName.add(c.LastName);
    system.debug('-------fName Data----- ' +lName);
    conPostcode.add(c.mailingPostalCode);
    system.debug('-------fName Data----- ' +conPostCode); 
 }
 
 for(account acc : accList){
     AccName.add(acc.Name);
     system.debug('------AccName Data------ ' +AccName);
     accPostCode.add(acc.shippingPostalCode);
     system.debug('------accPostCode Data---- ' +accPostCode);
 }
 
 if(trigger.isAfter){
     if(trigger.isInsert){
          contact con = new contact();
          for(Staging__c stg : trigger.new){
              stgList.add(stg);
              system.debug('-----staging object Data----' +stg);
              if(stg.Individual_or_Organization__c == 1){
                  if(fName.contains('stg.First_Name__c') && lName.contains('stg.Last_Name__c') && conPostCode.contains('stg.Postal_Code__c')){
                      system.debug('-----staging object Data----' +stg);
                  }else{
                      
                      con.FirstName = stg.First_Name__c;
                      con.LastName  = stg.Last_Name__c;
                      con.mailingPostalCode = stg.Postal_Code__c;
                      insert_con.add(con);
                  }
              }
          }
          insert insert_con ;
          
          for(contact c : insert_con){
              for(Staging__c sobj : stgList){
                  opportunityContactRole opp = new opportunityContactRole();
                  opp.contactId = c.id;
                  
                  opportunity op = new opportunity();
                  op.Name = c.Name + sobj.Date_Recieved__c; 
                  op.CloseDate = sobj.Date_Recieved__c;
                  op.StageName = 'Prospecting';
                  
                  insert_opp.add(op); 
              }
          }
          
          for(account acc : accList){
          system.debug('-------acc data---- ' +acc);
              for(Staging__c sobj : stgList){
              system.debug('-----sobj- data-----' +sobj);
                  if(sobj.Orgganization_Name__c != null && sobj.Postal_Code__c != null){
                  system.debug('----org Name----- ' );
                      if(acc.Name == sobj.Orgganization_Name__c){
                        system.debug('----$$$---sobj data--------'+sobj.Orgganization_Name__c);
                        orgId.add(acc.Id);
                        con.AccountId = acc.id;
                        system.debug('--------Account Id -------' +con.AccountId);
                        system.debug('--------Account Id -------' +acc.id);
                        insert_con.add(con);
                        system.debug('------insert contact list data---- ' +insert_con);
                        
                  /*    opportunity opp = new opportunity();
                        opp.Name = con.Name + sobj.Date_Recieved__c; 
                        opp.CloseDate = sobj.Date_Recieved__c;
                        opp.StageName = 'Prospecting';
                        opp.AccountId = acc.id;
                        insert_opp.add(opp);       */    
                      }
                  }
              }
          }
         // update insert_con ;
          insert insert_opp ;
          system.debug('------insert contact list data---- ' +insert_con);
     }
 }
 
 /* List<contact> conList = new List<contact>();
    List<account> accList = database.query('SELECT id , Name , AccountNumber , Industry , billingPostalCode FROM account');
    List<account> acc = new List<account>();
    
    set<string> Fname = new set<string>();
    set<string> Lname = new set<string>();
    List<Staging__c> stList = [Select id , First_Name__c , Last_Name__c , Name ,  Individual_or_Organization__c FROM Staging__c ];
         
    for(Staging__c stg : trigger.new){
        Fname.add(stg.First_Name__c);
        Lname.add(stg.Last_Name__c);
        system.debug('---------Fname---' +Fname);
        system.debug('---------Lname---' +Lname);
    } 
    
    conList = [SELECT id , contact.FirstName , contact.LastName ,  Name  from contact   ];
    system.debug('----------conList Data------ ' +conList);  

    for(Staging__c st : stList ){
    
    }
    if(stg.Individual_or_Organization__c == 1){
            system.debug('-------stg  data-----' +stg);
    }else{   
        contact con = new contact();
        con.FirstName = stg.First_Name__c;
        con.LastName  = stg.Last_Name__c;
        insert con;
        system.debug('--------new contact-----' +con);
           
    }
    
   */
        
}