public class AddMultipleAccountsController{
     
     Account account = new Account();
     public List<Account> ListAccount{get; set;}
     
     public AddMultipleAccountsController(){
     ListAccount = new List<Account>();
     ListAccount.add(account);
     }
     
     public void addaccount(){
     Account acc = new Account();
     ListAccount.add(acc);
     }
    
     public PageReference SaveAccount(){ 
     for(Integer i=0; i<ListAccount.size(); i++){
     insert ListAccount;
        }
        return page.AllAccountsSaved;
     }

}