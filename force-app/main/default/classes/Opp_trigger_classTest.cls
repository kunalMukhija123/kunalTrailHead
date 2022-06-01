@IsTest
public class Opp_trigger_classTest{

public static void Opp_trigger_classTestTotal(){
Double Total_Amount = 0 ;
opportunity o1 = new opportunity();
o1.Name ='abc';
o1.CloseDate = Date.today();
o1.StageName = 'closed won';
o1.Amount = 20000;
o1.Discount_Percent__c = 0;
Total_Amount = Total_Amount + o1.Amount ; 
if(Total_Amount < 100000){
insert o1;
}else
o1.addError('Exceeded Your Limit');
}
}