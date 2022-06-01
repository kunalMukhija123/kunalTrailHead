public class AccountContactMap{
    
    public Boolean isSelected{get ; set ;}
    public Map<ID,contact> Map1 {get;set;} 
    public List<contact> listCon {get;set;}
    
    public AccountContactMap()
    {
        Map1();
    }

    public void Map1(){
   
    Map1 = new Map<ID,contact>([Select id , FirstName , LastName , Email FROM contact]);
    listCon  = new List<contact>([Select id  FROM contact]);
    System.debug('------Map Data------:'+Map1);
    }
     
}