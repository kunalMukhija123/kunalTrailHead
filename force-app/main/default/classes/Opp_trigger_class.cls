public class Opp_trigger_class
{
public static void Opp_trigger_method(List<opportunity> ops){
Double Total_Amount = 0 ;
for(opportunity o1 : [select Amount from opportunity WHERE CreatedDate = Today AND CreatedByID =: UserInfo.getUserID()]){
Total_Amount = Total_Amount + o1.Amount ; 
}
for(opportunity o2 : ops){
Total_Amount = Total_Amount + o2.amount ;
if(Total_Amount > 100000)
o2.AddError('Exceeded Your Daily Limit');
}

}


}