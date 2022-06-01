trigger CheckDuplicateLeadAndContact on Lead(before insert, before update) {
    if ( trigger.isBefore ) {
        if ( trigger.isInsert ) {
            LeadHandlerController.onBeforeInsert(trigger.new);
        } 
        
        if ( trigger.isUpdate ) {
               LeadHandlerController.onBeforeUpdate(trigger.new, trigger.oldMap);
        } 
    } 
}