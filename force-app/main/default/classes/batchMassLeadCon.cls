global class batchMassLeadCon implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select Id, FirstName , LastName, Name, status, company FROM Lead ORDER By Name ASC';
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<Lead> scope) {
         for(Lead LD : scope)
         {
            if(LD.status != 'Closed - Converted'){
                Database.LeadConvert lc = new database.LeadConvert();
                lc.setLeadId(LD.Id);
                lc.ConvertedStatus = 'Closed - Converted';
                Database.LeadConvertResult lcr = Database.convertLead(lc);                
                System.assert(lcr.isSuccess());
            }
         }
    }   
    
    global void finish(Database.BatchableContext BC) {
        user usr = new user();
        usr = [select Id, Name , email from user where Id=: userinfo.getUserId()];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        sendTo.add(usr.Email);
        mail.setToAddresses(sendTo);
        mail.setSubject('Lead Conversion Job Completed');
        string body = 'Lead Conversion Job Completed Successfully';
        mail.setHtmlBody(body);
        mails.add(mail);
        Messaging.sendEmail(mails);
    }
}