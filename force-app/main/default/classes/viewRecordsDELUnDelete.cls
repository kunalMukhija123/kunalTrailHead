public class viewRecordsDELUnDelete{
    
    private integer totalRecs = 0;     
    private integer index = 0;
    private integer blockSize = 5;        
    
    
    public List<WrapperClass> wrap_ConList {get;set;}
    public List<WrapperClass> wrap_ConList1 {get;set;}
    public List<WrapperClass> wrap_ConList2 {get;set;}
    public List<WrapperClass> wrap_ConList3 {get;set;}
    public List<WrapperClass> wrap_ConList4 {get;set;}
    
    public String FirstName {get; set;}
    public String LastName {get; set;}
    public String Email {get; set;}
    public String Phone {get; set;}
    public String AccountId {get; set;}
    public List<contact> conList {get; set;}
    public String contactId {get;set;}
    public contact co {get;set;}
    
    public viewRecordsDELUnDelete(){
      totalRecs = [select count() from contact];
      system.debug('---- Size of List---- ' +totalRecs);
     
      conList = new List<contact>();
      co = new contact();
      wrap_ConList2 = new List<wrapperClass>();
      conList = new List<contact>([Select Id , firstName , lastName , email , phone , AccountId from contact]);
      
        system.debug('----conList Data records--- ' +conList);
        if(conList.size() > 0){
             wrap_ConList = new List<WrapperClass>();
             for(contact c : conList) {
                wrap_ConList.add(new WrapperClass(c));
            }
        }
        system.debug('-----wrapper List data---  ' +wrap_ConList);      
         searchContacts();
    }   
    
    public void searchContacts(){
        wrap_ConList.clear();
        
        conList.clear();
        system.debug('----input variables---- ' +co.FirstName +'------' +co.LastName +'---- ' +co.Email +'-------' +co.phone +'------' +co.AccountId);
        
        if(co.firstname == null && co.lastname == null && co.email == null && co.phone == null && co.AccountId == null){
            conlist=[select id,firstname,lastname,email,phone,accountid from contact LIMIT : blockSize OFFSET :index ]; 
            for(contact c :conlist){
                wrap_ConList.add(new wrapperClass(c));
            } 
        }else{
            conlist=[select id,firstname,lastname,email,phone from contact where (firstname=:co.firstname AND firstname!=null) OR (lastname=:co.lastname AND Lastname!=null) OR (email=:co.email AND email!=null) OR (phone=:co.phone AND phone!=null) OR (accountid=:co.accountid AND accountid!=null)];
            wrap_ConList = new List<WrapperClass>();
            for(contact c : conList) {
                wrap_ConList.add(new WrapperClass(c));
            }
        }
        
    /*  if(co.FirstName != null || co.LastName != null || co.Email != null || co.phone != null || co.AccountId != null){
            conList = new List<contact>([Select Id , firstName , lastName , email , phone , AccountId from contact where (firstName =: co.FirstName) OR (lastName =: co.LastName) OR
                                        (Email =:co.Email) OR (Phone =:co.Phone) OR (AccountId =:co.AccountId)]);
           
            if(conList.size() > 0){
                 wrap_ConList = new List<WrapperClass>();
                 for(contact c : conList) {
                    wrap_ConList.add(new WrapperClass(c));
                }
            }
        }     */
        system.debug('-----wrapper List data---  ' +wrap_ConList);
        
    }
    
    public void delContact(){
        wrap_ConList1 = new List<wrapperClass>();
       // wrap_ConList2 = new List<wrapperClass>();
        
        system.debug('-----del rec------ ' +contactId);
        if(contactId != null){
            for(wrapperclass wc : wrap_ConList){
                system.debug('------wc rec---- ' +wc);
                system.debug('------wc rec---- ' +wc.con);
                if(wc.con.Id != contactId){
                   wrap_ConList1.add(wc);
                }else{
                   wrap_ConList2.add(wc);
                }
            }
            wrap_ConList.clear();
            wrap_ConList = wrap_ConList1;
        }   
    }
    
 /* public void upRecords(){
        wrap_ConList3 = new List<wrapperClass>();
        if(wrap_ConList2.size() != null){
           wrap_ConList3.addAll(wrap_ConList2);
           wrap_ConList3.addAll(wrap_ConList);
           wrap_ConList.clear();
           wrap_ConList.addAll(wrap_ConList3);
           wrap_ConList2.clear();
        }
       
    }    */
     
    public void upRecords(){
        wrap_ConList3 = new List<wrapperClass>();
        wrap_ConList4 = new List<wrapperClass>();
        if(wrap_ConList2.size() != null){
           for(wrapperClass w : wrap_ConList2){
               system.debug('----w rec ---- ' +w);
               if(w.IsSelected == true){
                system.debug('----w rec ---- ' +w);
                w.IsSelected = false;
                wrap_ConList3.add(w);   
               }else{
                wrap_ConList4.add(w);   
               }
           } 
      //   wrap_ConList3.addAll(wrap_ConList2);
           wrap_ConList3.addAll(wrap_ConList);
           wrap_ConList.clear();
           wrap_ConList.addAll(wrap_ConList3);
        }
   /*   else if(wrap_ConList2.size() != null && wrap_ConList2.size() == 1){
           wrap_ConList3.addAll(wrap_ConList);
           wrap_ConList.clear();
           wrap_ConList.addAll(wrap_ConList3); 
        }  */
           wrap_ConList2.clear();
           wrap_ConList2.addAll(wrap_ConList4);
           system.debug('------List size after removing ele---- ' +wrap_ConList2.size());
           wrap_ConList4.clear();
    }    
    
    public List<contact> updateCon {get; set;}
    public void saveUpdate(){
        updateCon = new List<contact>();
        for(wrapperClass wc : wrap_ConList){
            if(wc.IsSelected == true){
                wc.IsSelected = false;
                updateCon.add(wc.con);
            }
        }
        update updateCon ;
    }
    
    public void beginning()
    {
        index = 0;
        searchContacts();
    }
    
    public void previous()
    {
        index = index - blockSize;
        searchContacts();
    }
    
    public void next()
    {
        index = index + blockSize;
        searchContacts();
    }

    public void end()
    {
        index = totalrecs - math.mod(totalRecs,blockSize);
        searchContacts();
    }        
    
    public boolean getprev()
    {
        if(index == 0)
        return true;
        else
        return false;
    }  
    
    public boolean getnxt()
    {
        if((index + blockSize) > totalRecs)
        return true;
        else
        return false;
    }   
        
    public class WrapperClass {
        
        public Boolean IsSelected {get;set;}
        public contact con {get;set;}
        public Integer counter{get;set;}
        
        public WrapperClass(contact con) {
            
            IsSelected = false;
            this.con = con;
        }        
    }

}