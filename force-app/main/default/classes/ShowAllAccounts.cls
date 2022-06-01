public class ShowAllAccounts {
    List<Account> accList = [SELECT Name , AccountNumber , ShippingAddress FROM Account];
  /*
    for(Account acc : accList){
        system.debug('-------Account Data------'+acc);
    }    */
}