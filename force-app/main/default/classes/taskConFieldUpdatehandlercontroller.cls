public class taskConFieldUpdatehandlercontroller{

    public static void onAfterInsert(List<task> taskList) {
      set<Id> taskwhoIds = new set<Id>();
      system.debug('------created tasks---- ' +taskList);
      for(task t : taskList){
          taskwhoIds.add(t.whoId);
      }
      contact con  = [select Id from contact where Id =: taskwhoIds];
      
      for(task t : taskList){
          con.LastTaskCreatedTime__c = t.CreatedDate;
          if(t.taskSubType == 'Email'){
              
          }
      }
      update con;
      
   /* SELECT Id, Name,(SELECT ActivityDate ,ActivityType ,Description ,
      CreatedBy.Name ,Status ,WhatId FROM ActivityHistories) FROM contact
     
      
      Id conId = con.Id;
      contact con1 = [SELECT (SELECT ActivityDate, Description from ActivityHistories) FROM contact WHERE Id =: conId];
      system.debug('----con1----  ' +con1);   */
    }
}