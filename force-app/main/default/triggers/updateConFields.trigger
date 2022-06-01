trigger updateConFields on task(after insert) {
    if ( trigger.isAfter ) {
        if ( trigger.isInsert ) {
             taskConFieldUpdatehandlercontroller.onAfterInsert(trigger.new);
        }
    }   
}