public class CreateContact {
    // public static string AccountId = '';
    
    @AuraEnabled
    public static List<contact> saveContact(Contact con , string con1) {
        List<contact> con_List = new List<contact>();
        //  AccountId = con1;
        for(integer i=0; i < con.Num_of_Con__c ; i++){
            contact c = new contact();
            c.LastName = con.LastName;
            c.FirstName = con.FirstName;
            c.AccountId = con1 ;
            con_List.add(c);
        }
        insert con_List;
        return con_List; 
    }
}