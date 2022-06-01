public class EmailTemplates{
          
    public contact con {get; set;}
    public String Template {get;set;}
    public List<contact> EmailAdd;
    public List<string> EmailList;
    public List<EmailTemplate> TemplateList{get; set;}
    public List<Contact> conList {get ; set;}
    public List<SelectOption> SelectOptionList{get; set;}
    public List<EmailTemplate> EmailContent {get; set;} 
    public String subject;
    public String body;
    
    public EmailTemplates(){
        con = new contact();
        
    }
    
    public List<SelectOption> getListOfTemplates(){
        TemplateList = new List<EmailTemplate>([Select Id, Name, Subject, TemplateType, FolderId, Folder.Name From EmailTemplate Where IsActive = true AND FolderId = '00D28000001OzUdEAK']);
        // TemplateList.add([Select Id, Name, Subject, TemplateType, FolderId, Folder.Name From EmailTemplate Where IsActive = true AND FolderId = '00D28000001OzUdEAK']);
        system.debug('-------Template List Data------'+TemplateList);
        
        List<SelectOption> SelectOptionList = new List<SelectOption>();
        SelectOptionList.add(new SelectOption( ' ' ,'---Select---'));
        for(EmailTemplate Temp : TemplateList){           
            
            SelectOptionList.add(new SelectOption(Temp.id , Temp.Name));
            system.debug('------Select Option List----'+SelectOptionList);
        }
    
     return SelectOptionList;
     
    }
    
    
    public pagereference SendEmail(){
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        
        EmailAdd = new List<contact>();
        system.debug('--------Selected  Record ID-------'+con);    
        EmailAdd = ([select id , Name , Email from Contact where id = :con.ReportsToId]);
        system.debug('Selected Record Email'+EmailAdd);
        
        EmailList = new List<string>();
        for(Contact c: EmailAdd){
            EmailList.add(String.valueOf(c.Email)); 
                if(!EmailList.isEmpty()){
                email.setToAddresses(EmailList);
            } 
        }
        system.debug('List Of Email Addresss'  +EmailList);
        
        system.debug('------42-----'+Template);
        EmailContent = [SELECT Id, Name, Subject , body FROM EmailTemplate WHERE Id =: Template];
        system.debug('-------45-------'+EmailContent);
        
        //email.setTemplateId(EmailContent.Id);
        for(EmailTemplate ET : EmailContent){
            subject = ET.Subject;
            body = ET.body;
        }
             
        email.setSubject(subject);
        email.setPlainTextBody(body);
        email.setToAddresses(EmailList);
        system.debug('------subject-----------'+subject);
        system.debug('------body-----------'+body);
        system.debug('------Address-----------'+EmailList);
         
        Messaging.sendEmailResult[] r = Messaging.sendEmail(new Messaging.singleEmailMessage[] {email}); 
        EmailList.clear();
        
        return Null;   
    }
}