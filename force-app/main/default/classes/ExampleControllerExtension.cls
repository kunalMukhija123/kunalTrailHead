//extension controller to display related opportunities
public class ExampleControllerExtension {

  //create an instance account variable to store the passed account record
  Account accountrec;

  public ExampleControllerExtension(ApexPages.standardController std){

    //get the accout record from the standard controller passed through the instance
    accountrec = (Account)std.getRecord();
  }
    // this method fetches the opportunity record every time the property if referenced in the apex page
    public List<opportunity> getRelatedOpprtunities() {
           return [Select Name, Amount, StageName From Opportunity Where AccountId = :accountrec.Id ];
    }
  
}