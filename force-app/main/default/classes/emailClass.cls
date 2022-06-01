public class emailClass{

    public string subject {get; set ;}
    public string emailBody {get; set;}    
    List<string> emails = new List<string>{' aashirwaad.mahatha@gmail.com ' };
    
    public pageReference sendEmail(){
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        email.setSubject(subject);
        emailBody = 'Hi' + ',' + ' ' + '{!Contact.Name}';
        email.setPlainTextBody(emailBody);
        if(email.PlainTextBody.contains('{!')){
            integer i = 1;
            system.debug('-----symbol-----'+i);
            string msg = email.PlainTextBody;
            system.debug('---Message contents-----'+msg);
        }else{
             integer j = 0;
             system.debug('-----No Sybmol----'+j);   
        }
    /*    email.setToAddresses(emails);
        Messaging.sendEmailResult[] r = Messaging.sendEmail(new Messaging.singleEmailMessage[] {email}); */
        return null;
    }
}