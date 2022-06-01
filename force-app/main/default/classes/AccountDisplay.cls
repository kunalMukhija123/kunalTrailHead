public class AccountDisplay {

    public account acc {get; set;}
    public contact con {get; set;}
    
    public AccountDisplay (){
    con=new contact();
    acc=new Account();
    }
        
    public pagereference getdetails(){
        system.debug('ccc=='+con);
        acc = [select id, name from account where id = :con.AccountId]; 
        return null;
    }
}