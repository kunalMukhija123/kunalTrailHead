@isTest
public class customerrUpdateTest{

static testMethod void testCustomer(){
    Customerr__c x = new Customerr__c();
    x.name = 'test1';
    x.salary__c = 1000 ; 
    insert x;
    
    x.name = 'testing';
    x.salary__c = 5000;
    update x;
    
    Test__c t = new Test__c();
    t.name = x.name;
    t.salary__c = x.salary__c;
    insert t;
}
}