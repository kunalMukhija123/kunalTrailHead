Public class AccHandlerclass{
    public static void updateAcc(List<Account> accList){
        List<contact> conList = new List<contact>();
        for(account acc : accList){
            for(Integer i=0; i< acc.count__C; i++){
                contact c = new contact();
                c.lastName = 'ABC';
                c.accountId = acc.Id;
                conList.add(c);
            }
        }
        insert conList;
    }
}