trigger updateAmount on contact(after insert, after update ) {
    if ( trigger.isAfter ) {
        if ( trigger.isInsert ) {
             accAmountHandlerController.onAfterInsert(trigger.new);
        }else if ( trigger.isUpdate ) {
             accAmountHandlerController.onAfterUpdate(trigger.new);
        }
    }   
}