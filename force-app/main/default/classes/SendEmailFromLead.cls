global class SendEmailFromLead implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Name, company FROM Lead WHERE createddate  = LAST_N_DAYS:7';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Lead> scope) {
        System.debug('----Lead Rec--->>> ' +scope);
        if(scope.size() != 0){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = new String[] { 'kunal.mukhija@360degreecloud.co.in' };
                message.subject = 'Lead Records of Last 7 days';
            
            String htmlBody = '';
            htmlBody = '<table border="1" style="border-collapse: collapse"><caption>Lead Records</caption><tr><th>Name</th><th>Company</th></tr>';
            
            for(Lead objLead : scope){
                
                String Name = objLead.Name; if(objLead.Name == null){Name = '';}
                String company = objLead.Company; if(objLead.Company == null){Company = '';}
                
                htmlBody += '<tr><td> + Name + </td><td> + Company + </td></tr>';
                
            }
            htmlBody += '</table>';
            
            message.plainTextBody = htmlBody;       
            
            Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            
            if (results[0].success){
                System.debug('The email was sent successfully.');
            } else{
                System.debug('The email failed to send: ' + results[0].errors[0].message);
            }
        }
    }   
    
    global void finish(Database.BatchableContext BC) {
        
    }
}