public class Candidates_Handler_Controller {

   // public static List<Contact> conList;
  //  public static List<Contact> new_conList = new List<contact>();
    
    public static void onAfterInsert(List<Candidates__c > CandidateList) {
        List<Account> broAccList = new List<Account>();
        List<Account> mgBroAccList = new List<Account>();
        List<contact> conList = new List<Contact>();
       // conList = new List<Contact>();
        List<Task> taskList = new List<Task>();
        List<User> userRoleList = new List<User>();
        
        for(Candidates__c can : CandidateList){
            if(can.Brokerage__c != null){
             Account bro_acc = new Account();
             bro_acc.Name = can.Brokerage__c;
             broAccList.add(bro_acc);
            }
            
            if(can.Manage_Brokerage__c != null){
             Account mgbro_acc = new Account();
             mgbro_acc.Name = can.Manage_Brokerage__c;
             mgBroAccList.add(mgbro_acc);
            }
        }          
                   
        if(broAccList.size() > 0){
            insert broAccList;
        }   
        
        if(mgBroAccList.size() > 0){
            insert mgBroAccList;
        }    
        
        for(Account bro_acc : broAccList){
            for(Account mgbro_acc :mgBroAccList){
                mgbro_acc.parentId = bro_acc.Id;
            }
        }  
        update mgBroAccList;
        
        for(Candidates__c can : CandidateList){
            for(Account acc : mgBroAccList){
                if(can.Last_Name__c != null){
                    contact con = new contact();
                    con.FirstName = can.First_Name__c;
                    con.LastName = can.Last_Name__c;
                    con.AccountId = acc.Id;
                    conList.add(con);
                }
            } 
        }
        
        if(conList.size() > 0){
            insert conList;
        }
   //     new_conList.addAll(conList);
   //     system.debug('-----new contact List ----' +new_conList);  
          
       for(Candidates__c can : CandidateList){
            for(contact con : conList){
                Task tk = new Task();                    
                tk.WhoId = con.Id;
                tk.WhatId = can.Id;
                tk.Subject = 'Portal Contact Setup';
                taskList.add(tk);
                system.debug('-----Task List------ ' +taskList);
            }
        }
        
        if(taskList.size() > 0){
            insert taskList;
        }    
    }
    
    
    public static void onAfterUpdate(List<Candidates__c> CandidateList, Map<Id, Candidates__c> mapCandOld) {
        system.debug('-----Map data ----- ' +mapCandOld);
        set<string> conID = new set<string>();
   //     Map<ID , contact> conMap = new Map<ID , contact>();
   //     set<ID> canIDs = new set<ID>();
        List<contact> conList = new List<contact>([select Id , Name from contact]);
                system.debug('-------84 ----- contact List---- ' +conList);
        
  /*      for(Candidates__c ca : CandidateList){
            canIDs.add(ca.Id);
        }    */
        system.debug('-------89 ----- candidate List---- ' +CandidateList);        
        for(Candidates__c ca : CandidateList){
            for(contact co : ConList){
                if(ca.Name == co.Name){
                    conID.add(co.Id); 
                }
            }
        }
        system.debug('--------96------ conID set data----' +conID);
        system.debug('-------96 ----- candidate List---- ' +CandidateList);
        for(Candidates__c can : CandidateList){
        Candidates__c candidateID = mapCandOld.get(can.Id);
            if(can.Candidate_Status__c == 'Webinar - Attended' && can.User_Created__c == false && can.User_Created__c != candidateID.User_Created__c){
             insertUserWithRole(conID);
             system.debug('-----user inserted-------');
            }
        }
    }    
    
    @future
    public static void insertUserWithRole(set<string> conID){
     List<User> userRoleList = new List<User>();
     
     UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
     Profile profile1 = [Select Id from Profile where name = 'Customer Community Login User'];
     system.debug('---------profile ID ----- ' +profile1);
     system.debug('---------profile Role ID ----- ' +portalRole);
     system.debug('---------profile ID ----- ' +conId);
     for(string c : conId){   
       system.debug('---------profile ID ----- ' +conId);
        User portalAccountOwner1 = new User(
    //    UserRoleId = portalRole.Id,
        ProfileId = profile1.Id,
       //  ProfileId = '00e28000001bI82',
      //   UserRoleId = '',
         Username = System.now().millisecond() + '@test.com',
         Alias = 'SuperMan',
         Email='bruce.wayne@way.com',
         CommunityNickname = 'super' + c,
         EmailEncodingKey='UTF-8',
         Firstname='Bruce',
         Lastname='Wayne',
         LanguageLocaleKey='en_US',
         LocaleSidKey='en_US',
         TimeZoneSidKey='America/Chicago',
         contactId = c
       //  contactId ='003280000113f9W'
        );
        userRoleList.add(portalAccountOwner1);
        system.debug('-------user Role List------- ' +userRoleList);
       } 
        system.debug('-------user Role List------- ' +userRoleList);
        if(userRoleList.size() > 0){
            insert userRoleList; 
            system.debug('-----success----');
        }
    }
}