public class ContactMapController{
    public List<Contact> contactList{get;set;}
    public Map<String,Boolean> selectedContactMap{get;set;}
    public List<contact> ContactsToShow{get;set;}
    public Boolean selectAllAccount{get;set;}
    Integer counter = 0;
    Integer limitSize = 10;
    Integer totalSize =0; 
    
        
    public ContactMapController(){
        contactList = new List<Contact>();
        selectedContactMap = new Map<String,Boolean>();
        contactList = [SELECT FirstName, LastName, Email FROM Contact ORDER BY Name ASC ];
        system.debug('-----Contact List Data------' +contactList);
        for(Contact con : contactList){
            selectedContactMap.put(con.id,false);
        }
        ContactsToShow = new list<contact>();
        totalSize = contactList.size();
        if((counter+limitSize) <= totalSize){
            for(Integer i=0;i<limitSize;i++){
                ContactsToShow.add(contactList.get(i));
            }
        }else{
            for(Integer i=0;i<totalSize;i++){
                ContactsToShow.add(contactList.get(i));
            }
        }
    }
    
    public void beginning(){
   
        ContactsToShow.clear();
        counter=0;
        if((counter + limitSize) <= totalSize){
       
            for(Integer i=0;i<limitSize;i++){
                ContactsToShow.add(contactList.get(i));
            }   
        } else{
            for(Integer i=0;i<totalSize;i++){
                ContactsToShow.add(contactList.get(i));
            }
        }
    }
    
    public void next(){
   
        ContactsToShow.clear();
        counter=counter+limitSize;
       
        if((counter+limitSize) <= totalSize){
            for(Integer i=counter;i<(counter+limitSize);i++){
                ContactsToShow.add(contactList.get(i));
            }
        } else{
            for(Integer i=counter;i<totalSize;i++){
                ContactsToShow.add(contactList.get(i));
            }
        }
    }
   
    public void previous(){
        ContactsToShow.clear();
        counter=counter-limitSize; 
        for(Integer i=counter;i<(counter+limitSize); i++){
            ContactsToShow.add(contactList.get(i));
        }
    }

    public void last (){
        ContactsToShow.clear();
        if(math.mod(totalSize , limitSize) == 0){
            counter = limitSize * ((totalSize/limitSize)-1);
        } else if (math.mod(totalSize , limitSize) != 0){
            counter = limitSize * ((totalSize/limitSize));
        }
        for(Integer i=counter;i<totalSize;i++){
                ContactsToShow.add(contactList.get(i));
        }
    }
   
    public Boolean getDisableNext(){
        if((counter + limitSize) >= totalSize)
            return true ;
        else
            return false ;
    }
    
    public Boolean getDisablePrevious(){
        if(counter == 0)
            return true;
        else
            return false;
    } 
   
   public Integer getPageNumber(){
        return counter/limitSize + 1;
   }
    
  
    
    public Integer getTotalPages(){
        if (math.mod(totalSize, limitSize) > 0){
            return totalSize/limitSize + 1;
        }else{
            return (totalSize/limitSize);
        }
    }
    public void save(){
        List<contact> updateConList = new List<contact>();
        for(contact c: contactList){
        selectAllAccount = selectedContactMap.get(c.id);
            if(selectAllAccount == true){
                updateConList.add(c);
            }
            update updateConList;
        }
    
        for(Contact con : contactList){
            selectedContactMap.put(con.id,false);
        } 
        selectAllAccount=false;
    }
    
    public void del(){
        List<contact> DeleteConList = new List<contact>();
        List<contact> tempConList = new List<contact>();
        for(contact c: contactList){
            selectAllAccount = selectedContactMap.get(c.id);
            if(selectAllAccount != true){
                tempConList.add(c);
            }else{
                DeleteConList.add(c);
            }
        }
        if(DeleteConList.Size()>0){
                delete DeleteConList;
            }
         contactList = tempConList;
    }
    
    public void SelectAll(){
        for(String cId : selectedContactMap.keyset()){
            selectedContactMap.put(cId,selectAllAccount);
        }
    }
}