public class updatecontact{
    
    public contact conObj{get; set;}
    public updatecontact(){
        conobj = new contact();
    }
    
    public void savecon(){
        System.debug('-----cont obj-->>>> ' +conObj);
        contact con = new contact();
        con.AccountId = conObj.AccountId;
        con.lastName = conObj.lastName;
        con.firstName = conObj.firstName;
        insert con;
        system.debug('-----obj inserted --->   ' +con.id);
    }
}