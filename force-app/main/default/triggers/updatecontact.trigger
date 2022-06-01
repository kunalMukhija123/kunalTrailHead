Trigger updatecontact on Account (before update, after delete) {
 
  if(trigger.isbefore && trigger.isupdate){
      map<id,account> mapcon = trigger.newmap;
      system.debug('------map con data----' +mapcon);
      list<contact> cont = new list<contact>();
      list<contact> con = [select id,phone,accountid from contact where accountid in : mapcon.keyset()];
      system.debug('------con List data----  ' +con);
      for(contact c : con){
       c.phone = mapcon.get(c.accountid).phone;
       cont.add(c);
    
      }
      update cont; 
  }
  
  if(trigger.isafter && trigger.isdelete){
   map<id,account> delcon = trigger.oldmap;
   system.debug('--------delcon List Data----- ' +delcon );
   list<contact> ccc = [select id from contact where accountid in : delcon.keyset()];
   delete ccc;
  
 
  }        
}