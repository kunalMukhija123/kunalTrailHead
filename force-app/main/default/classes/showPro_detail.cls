public class showPro_detail {
    
    public string input_data{get;set;} 
    public string Argument {get;set;} 
    list<string> stLIst {get;set;}
    public List<product2> proList{get;set;} 
    public Product2 pr{get;set;}
    public List<pricebookentry> pb{get;set;} 
    public decimal std_price{get;set;}
    
    public showPro_detail(){
        pr = [Select Id , Name ,(select Id , pricebook2.Name , unitPrice from pricebookentries) , specification__c From Product2 where id=: '01t280000036PTMAA2'];
        pb = pr.PricebookEntries;
         String c = ')';
        Argument = pr.Specification__c;
        input_data = Argument ;
        Argument = Argument.replaceAll('[\n\r]', '<~>');
        Argument = Argument.replaceAll('<~><~><~><~>', '<~><~>');
        Argument = Argument.replaceAll('<~><~>', '<br/>');
        
        Argument = Argument.replaceAll('GENERAL SPECIFICATIONS:', 'GENERAL SPECIFICATIONS:<br/>');
        Argument = Argument.replaceAll('EQUIPPED WITH:', '<br/>EQUIPPED WITH:<br/>');  
        //Argument = Argument.replaceAll(':', ':<br/>');
        Argument = Argument.replaceAll('”', '”<br/>');
        /*Argument = Argument.replaceAll('/min', '/min<br/>');
        Argument = Argument.replaceAll('lb', 'lb<br/>');
        Argument = Argument.replaceAll('HP', 'HP<br/>');
        Argument = Argument.replaceAll('RPM', 'RPM<br/>');
        Argument = Argument.replaceAll('PSI', 'PSI<br/>');
        Argument = Argument.replaceAll('Gal', 'Gal<br/>');   */
        
    //    Argument = Argument.replaceAll('<br/>'+c, ''+c);
    //
        
        
        std_price = pb[0].unitPrice;
        system.debug('-----7897----' +std_price);
        //   for(product2 pr : proList){
        system.debug('------ProList Spec---- ' +pr.Id);
        system.debug('------ProList Spec---- ' +pr.specification__c);
        system.debug(pr.specification__c.split('\r\n'));  
        
        stLIst = pr.specification__c.split('\r\n');
        system.debug('-----stlist----- ' +stList);
        for(integer i=0;i< stList.size(); i++){
            stList[i] = stList[i] + '\r\n' + '\r\n';
            //   pr.specification__c = stList[i];
            system.debug(stList[i]);
            
        }   
        /*      for(string st : StList){
system.debug('------st value---- ' +st);
pr.specification__c = pr.specification__c + st +''+ '<br>';
if(pr.specification__c != null && pr.specification__c.contains('<br>')){
pr.specification__c.replace('<br>', '<br><br>');
}
}  */
        
        
        //   }
        
    }
    
}