trigger taskTrigger on contact( after insert, after update ){
   
   if ( trigger.isAfter ) {
        if ( trigger.isInsert ) {
           //  taskConFieldUpdatehandlercontroller.onAfterInsert(trigger.new);
        }
   }
}