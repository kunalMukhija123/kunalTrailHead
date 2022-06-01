trigger customerr_Update on Customerr__c (before update) {
    List<Test__c> test = new List<Test__c>();
    for(Customerr__c x : trigger.new){
        Test__c t = new Test__c();
        t.name = x.name;
        t.salary__c = x.salary__c;
       // t.phone__c = x.phone__c;
        test.add(t);
    }
    insert test;
}