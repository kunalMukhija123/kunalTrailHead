public class AccountContactsController{

    public List<ContactWrapper> ConWrapList{ get; set; }
    
    public AccountContactsController(){
    
        ConWrapList= new List<ContactWrapper>();
        List<Contact> conList = [Select FirstName , LastName , Email from Contact ];
        for(contact con : conList){
           ConWrapList.add(new ContactWrapper(con));
        }
        
        system.debug('wrapper List Data : '+ ConWrapList );
        
        
    }
    public class ContactWrapper{
    
        public Boolean isSelected{get ; set ;}
        public Contact conObj{get ; set ;}
        
        public ContactWrapper(Contact conObj){
            this.conObj =conObj;
            isSelected = false;
        }
    }
    
        public void save(){
           List<Contact> contactList = new List<Contact>();
  
           for(contactwrapper c : conWrapList){
             if(c.isSelected==true){
              contactList.add(c.conObj);
              c.isSelected=false;
             }
           }
           update contactList;
             
         /*PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());    
         pageRef.setRedirect(true);
         return pageRef; */
        }    
        
        public void Del() {
            List<contact> recToDelete = new List<contact>();
            for(contactwrapper c: conWrapList){
                if(c.isSelected == true){
                       recToDelete.add(c.conObj);
                      
                }
            }

            if(recToDelete.size() > 0 ){
                Delete recToDelete;
            }
            
            ConWrapList= new List<ContactWrapper>();
            List<Contact> conList = [Select FirstName , LastName , Email from Contact ];
 
            for(contact con : conList){
                
                ConWrapList.add(new ContactWrapper(con));
            }
            system.debug('---------Updated wrapper List Data------------ : '+ ConWrapList );

    
        }
}