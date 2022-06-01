trigger updatePaymentFields on opportunity(after insert, after update) {
    if ( trigger.isAfter ) {
        if ( trigger.isInsert ) {
             createPaymentRechandlercontroller.onAfterInsert(trigger.new);
        }else if ( trigger.isUpdate ) {
             createPaymentRechandlercontroller.onAfterUpdate(trigger.oldMap , trigger.newMap);
        }
    }   
}