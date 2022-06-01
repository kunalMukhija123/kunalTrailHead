trigger CreateMyProjectFromProjTask on PROJECT_TASK__c (after insert) {
List<PROJECT_TASK__c> ProjectTask = new List<PROJECT_TASK__c>();
for(PROJECT_TASK__c p : trigger.new){
if(!string.isBlank(p.id)){
ProjectTask.add(p);
system.debug('---------Project Task Name -------' +ProjectTask);
}
}
if(ProjectTask.Size()>0){
List<MY_PROJECT_TASK__c> MyProjectTask = new List<MY_PROJECT_TASK__c>();
for(PROJECT_TASK__c p : ProjectTask){
MY_PROJECT_TASK__c Pro = new MY_PROJECT_TASK__c(Name = p.Name, PROJECT_TASK__c = p.ID);
MyProjectTask.add(pro);
system.debug('--------My Project Task -------' +MyProjectTask);
}
insert MyProjectTask;
}

}