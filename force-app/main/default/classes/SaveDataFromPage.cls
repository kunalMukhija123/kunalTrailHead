public class SaveDataFromPage{
    
    
    public contact con{get;set;}
    public String lastName{get;set;} // input text1 value  from vf
    public SaveDataFromPage(){
        con = new contact(); //  Either salesObj is standard or custom object

    }     
      public void saveRec(){

        
        con.LastName =  lastName;  
        system.debug('------duruityu------' +lastName);
        // Field Assignment
        if(con.lastName != null){
            insert con;
        }
        system.debug('----contact inserted-----' +con);
        List<contact> conList = new List<contact>([select id , Name from contact]);
        system.debug('---List Data-----' +conList);

      }  
      
}