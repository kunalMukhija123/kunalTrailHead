public class CheckAllUsingJavascriptExtension {
    public List<Account> AccountList {get; set;}
    
    public CheckAllUsingJavascriptExtension(ApexPages.StandardController controller) {
    if(AccountList == null) {
            AccountList = new List<Account>();
            for(Account a: [select Id, Name,AccountNumber,OwnerId,Site,NumberOfEmployees,Industry,Phone,Rating,YearStarted,TickerSymbol from Account limit 10]) {
                // As each Account is processed we create a new Account object and add it to the AccountList
                AccountList.add(new Account());
    }

}
}
public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
 
        //This is the contructor method. When we create a new wrapAccount object we pass a Account that is set to the acc property. We also set the selected value to false
        public wrapAccount(Account a) {
            acc = a;
            selected = false;
        }
    }
}