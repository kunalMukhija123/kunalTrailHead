trigger CreateAccountContact on Account (after insert, after update) {

    if(Trigger.isInsert)
    {
        List<contact> con= new List<contact>();
        for(Account acc : Trigger.new){
    
        Contact c= new Contact(lastname = acc.name ,AccountID= acc.id, Fax=acc.Fax, MailingStreet=acc.BillingStreet, 
        MailingCity = acc.BillingCity , MailingState=acc.BillingState, MailingPostalCode= acc.ShippingPostalCode , 
        MailingCountry = acc.BillingCountry , Phone = acc.Phone);
    
    
        con.add(c);
    
    }
    
        insert con;
    }
    
    
}