public class GetLookupRecordId{
          
    public contact con {get; set;}
    public string subject {get; set ;}
    public string emailBody {get; set;}  
    public string body; 
    public Id recId;
    public List<contact> EmailAdd;
    public List<string> EmailList;
    List<string> msg = new List<string>();
    
    public GetLookupRecordId(){
        con = new contact();
    }
            
    public pagereference SendEmail(){
        system.debug('ccc=='+con);
        EmailAdd = [select id , Name , Email from Contact where id = :con.ReportsToId];
        system.debug('Selected Record Email'+EmailAdd);
        
        EmailList = new List<string>();
        for(Contact c: EmailAdd){
            EmailList.add(String.valueOf(c.Email)); 
            recId = c.id;
            system.debug('-----value of recId----'+recId); 
        //    body = 'Hi' + ' ' + c.Name + ', \n' + ' \n ';
            system.debug('----Body Value----'+body);  
        }
        system.debug('List Of Email Addresss'  +EmailList);
        
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
       // email.setTargetObjectId(recId);
        email.setSenderDisplayName('ABC');
        email.setSubject(subject);
        email.setPlainTextBody(emailBody);
  
        
             List<string> ListofStrings = new List<string>();
             List<string> ListofStrings1 = new List<string>();
             string str = email.plainTextBody;
             system.debug('-----------plain text body------'+str);
             Integer count = str.countMatches('contact');
             system.debug('-----count value-----'+count);
             integer i = 0 ;
             integer p = 0 ;
             for(p = 0 ; p < count ; p++){
                 integer found = str.indexOf('{!', i);
                 system.debug('-----value of found------'+found);
                 integer start = found ; 
                 system.debug('-----value of start----'+start);
                 integer endInd = str.indexOf('}', start);
                 endInd = endInd + 1 ;
                 system.debug('-----value of end----'+endInd);
                 
                 string strOFstr = str.substring(start, endInd);
                 System.debug(+str.substring(start, endInd));
                 ListofStrings.add(str.substring(start, endInd));
                 system.debug('======56==='+ListofStrings);
                 ListofStrings1.add(+strOFstr.substringBetween('{!contact.','}'));
                 i =  endInd + 1 ; 
             }
             system.debug('----List of Strings----'+ListofStrings);
             system.debug('----List of Strings----'+ListofStrings1);
             
             string reqField = '';
             for(string rec : ListofStrings1){ 
                 reqField = string.valueOf(reqField) + string.valueOf(rec) + ' ' +',';
                 
             }
             reqField = reqField.removeEnd(',');             
             system.Debug('------8787779-----'+reqField);
             string reqFieldValues = 'SELECT Id , '+reqField+' from contact where id = :recId ';
             List<Contact> reqFieldData = database.query(reqFieldValues);   
             

       /*      for(string st : ListofStrings){
                 for(contact ct : reqFieldData){
                     system.debug('=====value of ct==='+ct);
                     if(str.contains(string.valueOf(st))){
                         system.debug('=====boolean result==='+str.contains(string.valueOf(st)));
                         str = str.replace(string.valueof(st), string.valueof(ct)); 
                     }
                 }
             }   */
             
          //   if(ListofStrings1)
                 for(string st : ListofStrings1){
                     
                     
                     
                 }
             
          /*     for(string st : ListofStrings){
                     
                     if(str.contains(string.valueOf(st))){
                         system.debug('=====boolean result==='+str.contains(string.valueOf(st)));
                         str = str.replace(string.valueof(st), string.valueof(reqFieldData[0].name));
                     }
                 }
                 
             system.debug('------Replaced Data----'+str);    */
        
   /*     if(!EmailList.isEmpty()){
            email.setToAddresses(EmailList);
            Messaging.sendEmailResult[] r = Messaging.sendEmail(new Messaging.singleEmailMessage[] {email}); 
        }       
        EmailList.clear();   */ 
        return null;
    }
}