public with sharing class AccountController {

public List<SelectOption> getListOfAccounts()
{
           List<Account> AccountList = [select id,Name from Account] ;
           System.debug('Accounts'+AccountList.size());
           List<SelectOption> AccountOptionList = new List<SelectOption>();
           AccountOptionList .add(new SelectOption( ' ' ,'---Select---'));
           for(Account acc : AccountList )
           {
                      AccountOptionList .add(new SelectOption(acc.id , acc.Name));
           }
          return AccountOptionList ;
}

    public String selectedaccountId { get; set; }

    public AccountController() {

    }
}