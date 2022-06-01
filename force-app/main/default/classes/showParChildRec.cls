public class showParChildRec {
    public List<goal__c> goalList {get; set;}
    private final Account myAccount;
    
    public showParChildRec() {
        goalList = [select Id , Name, ( Select Id, Activitydate from Activities__r) from goal__c ];
        system.debug('-------list data -----   ' +goalList);
    }
}