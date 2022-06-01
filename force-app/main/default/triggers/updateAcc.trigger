trigger updateAcc on Account(After insert){
    if(trigger.isAfter){
        if(trigger.isInsert){
            AccHandlerclass.updateAcc(trigger.new);
        }
    }
}