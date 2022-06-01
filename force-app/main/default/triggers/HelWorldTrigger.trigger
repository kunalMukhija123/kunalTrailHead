trigger HelWorldTrigger on Account (after delete , after update , after undelete ){
    
    List<Account> accList = new List<Account>();
    for(integer i = 0 ; i < 5 ; i++){
        Account acc = new Account();
        acc.Name = 'Test' + 'Acc' + i;
        acc.description = 'New Description is here';
        insert acc; 
        accList.add(acc);
    }
    
    system.debug('-----old record--- ' +trigger.new);
    system.debug('----list of acc---- ' +accList);
    
    for(account acc : accList){
            acc.description = 'New Description is new  ......';        
        }
    system.debug('----list of acc---- ' +accList);
    system.debug('-----old record--- ' +trigger.old);
    system.debug('-----old record--- ' +trigger.new);
   
   
}