public class MemberPopup 
{
    public List<Member__c> memberList {get;set;}
    public List<Member__c> memberAddList {get;set;}
    public String memberName {get;set;}
    public Integer rowNum{get;set;}
    
    public MemberPopup()
    {
        String sql = 'SELECT Name, E_Mail_Id__c FROM Member__c';
        memberList = Database.Query(sql);
        memberAddList = new List<Member__c>();
        memberAddList.add(new Member__c());
    }
        
    public void AddRow()
    {
        memberAddList.add(new Member__c());
    }
    
    public void delRow()
    {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        memberAddList.remove(rowNum);   
    }    
    
    public void saveMemb()
    {
        insert memberAddList;
    }
}