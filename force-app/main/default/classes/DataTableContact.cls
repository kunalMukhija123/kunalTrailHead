public class DataTableContact{
    
    public String firstnameNewValue{ get; set; } 
    public String lastnameNewValue{ get; set; }  
    public String emailNewValue{ get; set; } 
    public String mobileNewValue{ get; set; } 
    public String contactToEdit { get; set; }
    public Map<id, Contact> contactMap{get;set;}
    
    public Id recId{ get;set; }
    public string fileName 
    {    get;set;    }
    
    public Blob fileBody 
    {    get;set;    }
    public DataTableContact(ApexPages.StandardController ctlr)
    {
       recId = ctlr.getRecord().Id;     
    }
    
    public void getUploadFile()
    {
        PageReference pr;
        if(fileBody != null && fileName != null)
        {
          Attachment myAttachment  = new Attachment();
          myAttachment.Body = fileBody;
          myAttachment.Name = fileName;
          myAttachment.ParentId = recId;
          insert myAttachment;
   /*     pr = new PageReference('/' + myAttachment.Id);
          pr.setRedirect(true);
          return pr;   */
        }
       // return null;
    }    
    
    
    
    
    public dataTableContact(){
        contactMap = new Map<id, Contact>();
         query();
         system.debug('----Email ----' +emailNewValue); 
    }
    
    public void saveChanges(){  
          Apexpages.Message msg = new Apexpages.Message(Apexpages.Severity.Confirm, 'Account changes saved successfully');  
          Apexpages.Message error_msg = new Apexpages.Message(Apexpages.Severity.Confirm, 'An error occured while saving account changes. Please contact your admin.');  
          if(this.contactMap == null){  
               this.query();  
          }  
          if(this.firstnameNewValue != null){  
               this.contactMap.get(contactToEdit).FirstName = this.firstnameNewValue;  
          } 
          if(this.lastnameNewValue != null){  
               this.contactMap.get(contactToEdit).LastName = this.lastnameNewValue;  
          }                                                                                         
          if(this.emailNewValue != null){  
          
               this.contactMap.get(contactToEdit).Email = this.emailNewValue; 
              
          }  
          if(this.mobileNewValue != null){  
               this.contactMap.get(contactToEdit).MobilePhone = this.mobileNewValue; 
               system.debug('----Mobile ----' +contactMap.get(contactToEdit).MobilePhone);  
          }  
          try{  
               update this.contactMap.get(contactToEdit);  
               Apexpages.addMessage(msg);  
          } catch(Exception e) {  
               Apexpages.addMessage(error_msg);  
          }  
    }  
    
    public void query(){
        
        for(Contact obj : [SELECT Id , FirstName , LastName , MobilePhone , Email FROM contact LIMIT 1000]){
           contactMap.put(obj.Id, obj);
        }  
    }
}