trigger tocreatePortal_User on Candidates__c (after insert , after update) {
    if(trigger.isAfter){
            if(trigger.isInsert){
                Candidates_Handler_Controller.onAfterInsert(trigger.new);
            }else if(trigger.isUpdate){
                Candidates_Handler_Controller.onAfterUpdate(trigger.new , trigger.oldMap);
            }
    }
}