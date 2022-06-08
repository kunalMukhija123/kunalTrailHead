@istest
Public class testCreateContactFrmEmail {

    static testMethod void testCreateContactFrmEmail() {
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
    
        email.subject = 'Create Contact';
        email.plainTextBody = 'FromEmail';
        env.fromAddress = 'ilovenagpur@gmail.com';    
        CreateContactFrmEmail creatC = new CreateContactFrmEmail();
        creatC.handleInboundEmail(email, env );
    }
}