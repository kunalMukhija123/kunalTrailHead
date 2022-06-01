@isTest
public class updateNumberofContacts_test{
    public static testMethod void testContact(){
        Account acc1 = new Account();
        acc1.Name = 'testAcc1';
        acc1.Number_of_Contacts__c = 3;
        insert acc1 ;    
        
        Account acc2 = new Account();
        acc2.Name = 'testAcc2';
        acc2.Number_of_Contacts__c = 0;
        insert acc2 ;
        
        contact con = new contact();
        con.LastName = 'kunal';
        insert con ;
    }
}