public class ClassController {

public List<aAccount> AccountList {get; set;}

public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                con = new ApexPages.StandardSetController(Database.getQueryLocator([select Id, Name, Phone , AccountNumber , OwnerID , TickerSymbol , NumberOfEmployees , Rating , YearStarted from Account limit 10]));
                // sets the number of records in each page set
                con.setPageSize(5);
            }
            return con;
        }
        set;
    }
 // public List<aAccount> AccountList {}

public List<aAccount> getAccounts() {
        AccountList = new List<aAccount>();
        for (Account c : (List<Account>)con.getRecords())
            AccountList.add(new aAccount(c));

        return AccountList;
    }
    
 public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }    

/*   public List<aAccount> getAccounts() {
if(AccountList == null) {
           AccountList = new List<aAccount>();
for(Account a: [select Id, Name, Phone , AccountNumber , OwnerID , TickerSymbol , NumberOfEmployees , Rating , YearStarted from Account limit 10]) {
        AccountList.add(new aAccount(a));

            }
        }
      return AccountList;
    }    */
    
public class aAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
    
public aAccount(Account a) {
            acc = a;
            selected = false;
        }
    }

    
    
}