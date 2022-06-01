trigger updateAccount on contact (After Insert , After Update , After delete , After unDelete){
    if(trigger.isAfter){
        if(trigger.isInsert||trigger.isUndelete){
             contactTriggerHandler.UpdateAccount(trigger.new);
        }
        if(trigger.isUpdate){
             contactTriggerHandler.UpdateAccount(trigger.new);
        }
        if(trigger.isDelete || trigger.isUpdate){
             contactTriggerHandler.UpdateAccount(trigger.old);
        }
    }
}