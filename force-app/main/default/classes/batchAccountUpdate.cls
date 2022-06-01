global class batchAccountUpdate implements Database.Batchable<sObject>{
    
    global Database.queryLocator Start(Database.BatchableContext BC){
        string query = 'SELECT id , Name FROM Account';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext Bc, List<Account> scope){
        for(Account acc : scope){
            acc.Name = acc.Name ;
        }
        update scope;        
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
    global void execute(SchedulableContext sc)
    {
        batchAccountUpdate accObj = new batchAccountUpdate();
        database.executebatch(accObj,10);
    }
}