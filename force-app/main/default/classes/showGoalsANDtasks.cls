Public class showGoalsANDtasks{
    public set<ID> goalIDs = new set<ID>();
    public List<task> taskList {get;set;} 
    
    public showGoalsANDtasks(){
        List<Goal__c> goalList = [Select Id, Name, Status__c From Goal__c];
        system.debug('----List data------' +goalList);
        set<Id> goalIDs = new set<Id>();
        for(Goal__c g : goalList){
            goalIDs.add(g.Id);
        }
        system.debug('------set data---- ' +goalIDs);
        taskList = [Select ID , Priority , goal__r.Id , goal__r.Name , Activitydate from Task where goal__r.Id In: goalIDs];
        system.debug('========task === ' +taskList);   
    }     
        
        
}