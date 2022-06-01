public class ChangeOwnerCtrl {

    private ApexPages.StandardSetController standardSetController;
    public List<sObject> selectedListViewRecords{get;set;}
    public Opportunity objOpportunity {get;set;}
    public String ownerId{get;set;}
    public Boolean selectedCheckBox {get;set;}
    public String jsonString{get;set;}
 
    public ChangeOwnerCtrl (ApexPages.StandardSetController standardSetController)
    {
        selectedCheckBox = false;
        System.debug('--13--selectedCheckBox---->>>>..... ' +selectedCheckBox);
        jsonString = '[ ';
        for(User userObj : [Select Id, Name from User where IsActive =  true Order by Name]){
            jsonString += '{"id": "'+userObj.id+'", "text": "'+userObj.name+'" }, ';
        }
        jsonString += ']';
        jsonString = jsonString.replace(jsonString.subString(jsonString.length()-3, jsonString.length()), ']');
        objOpportunity = new Opportunity();
       // System.debug('=====objOpportunity.ownerId:'+objOpportunity.ownerId);
       // selectedListViewRecords = new List<Opportunity>();
        this.standardSetController = standardSetController;
        // Apex code for handling records from a List View goes here
        List<sObject> listViewRecords = (List<sObject>) standardSetController.getRecords();
        selectedListViewRecords = (List<sObject>) standardSetController.getSelected();
        System.debug('=====selectedListViewRecords :'+selectedListViewRecords );
        if(selectedListViewRecords.size() == 0)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select at least 1 record'));
            return ;
        }
    }
    
    /*public PageReference doSomething()
    {
        return null;
        
    }*/
 
    public PageReference changeOwner()
    {
        try
        {
            System.debug('---44-selectedCheckBox---->>>>..... ' +selectedCheckBox);
            List<String> lstObjectId = new List<String>();
            System.debug('=====objOpportunity.ownerId:'+objOpportunity.ownerId);
            
            Boolean hasMore = standardSetController.getHasNext();
            System.debug('=====hasMore:'+hasMore);
            for(sObject objOpp : selectedListViewRecords )
            {
                lstObjectId.add(objOpp.id);    
            }
            System.debug('----lstObjectId---->>>>>...... ' +lstObjectId);
            
            List<sObject> lstOpportunityToUpdate = new List<sObject>();
            List<Task> lstOfTaskToUpdate = new List<Task>();
            List<sObject> lstOpportunity = new List<sObject>();
            List<Task> lstOfTask = new List<Task>();
            if(lstObjectId.size() > 0 && lstObjectId[0].startsWith('006')){
                lstOpportunity = [Select id, ownerId from Opportunity where id in : lstObjectId limit 10000];
                if(selectedCheckBox){
                    lstOfTask = [Select Id, whatId, ownerId From Task Where whatId In : lstObjectId limit 10000];
                    System.debug('--60--lstOfTask--->>>..... ' +lstOfTask);
                }
            }else if(lstObjectId.size() > 0 && lstObjectId[0].startsWith('003')){
                lstOpportunity = [Select id, ownerId from Contact where id in : lstObjectId limit 10000]; 
                if(selectedCheckBox){
                    lstOfTask = [Select Id, whoId, ownerId From Task Where whoId In : lstObjectId limit 10000];
                    System.debug('--65--lstOfTask--->>>..... ' +lstOfTask);             
                }
            }else if(lstObjectId.size() > 0 && lstObjectId[0].startsWith('00Q')){
                lstOpportunity = [Select id, ownerId from Lead where id in : lstObjectId limit 10000]; 
                if(selectedCheckBox){
                    lstOfTask = [Select Id, whoId, ownerId From Task Where whoId In : lstObjectId limit 10000];
                    System.debug('--70--lstOfTask--->>>..... ' +lstOfTask);
                }
            }
            else if(lstObjectId.size() > 0 && lstObjectId[0].startsWith('001')){
                lstOpportunity = [Select id, ownerId from Account where id in : lstObjectId limit 10000]; 
                if(selectedCheckBox){
                    lstOfTask = [Select Id, whatId, ownerId From Task Where whatId In : lstObjectId limit 10000];
                    System.debug('--76--lstOfTask--->>>..... ' +lstOfTask);
                }
            }else if(lstObjectId.size() > 0 && lstObjectId[0].startsWith('500')) {
                lstOpportunity = [Select id, ownerId from Case where id in : lstObjectId limit 10000];            
                if(selectedCheckBox){
                    lstOfTask = [Select Id, whatId, ownerId From Task Where whatId In : lstObjectId limit 10000];
                    System.debug('--81--lstOfTask--->>>..... ' +lstOfTask);             
                }
            }
            /*
            else if(lstObjectId.size() > 0 && lstObjectId[0].startsWith('701')){ 
                lstOpportunity = [Select id, ownerId from Campaign where id in : lstObjectId limit 10000]; 
                if(selectedCheckBox){
                    lstOfTask = [Select Id, whatId, ownerId From Task Where whatId In : lstObjectId limit 10000];
                    System.debug('--86--lstOfTask--->>>..... ' +lstOfTask);                             
                }
            }
            
            for(sObject objOpport : lstOpportunity)
            {   
                objOpport.put('ownerId', objOpportunity.ownerId);
                lstOpportunityToUpdate.add(objOpport);
            }
            if(lstOpportunityToUpdate.size() > 0)
            {
                update lstOpportunityToUpdate;
            }
            
            if(lstOfTask.size() > 0){
                for(Task objTask : lstOfTask){ 
                    objTask.put('ownerId', objOpportunity.ownerId); 
                    lstOfTaskToUpdate.add(objTask);
                    System.debug('------114---lst task to update --->>>>........' +lstOfTaskToUpdate);
                    System.debug('------115---lst task to update --->>>>........' +lstOfTaskToUpdate.size());
                }
            }
            
            try{
                if(lstOfTaskToUpdate.size() > 0){
                    System.debug('========119------>>>>');
                    update lstOfTaskToUpdate;
                    System.debug('----lstOfTaskToUpdate---->>>>... ' +lstOfTaskToUpdate);
                }
            }catch(Exception e){
                System.debug('----Exception---->>>>...... ' +e);
            }   */
            
            if(lstObjectId.size() > 0)
            {
                return new PageReference('/'+lstObjectId [0].subString(0,3)).setRedirect(true);
            }
            else
            {
                return null;
            }   
       }catch(Exception ex)
       {
           String error = ex.getMessage();
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,error));
           return null;
       }      
    }

}