public class AccountOverrideExtension {

    public Account acc {get; set;}
    public Boolean isEdit {get; set;}
    public AccountOverrideExtension(ApexPages.StandardController controller) {
        acc = (Account) controller.getRecord();
        String modeStr = ApexPages.currentPage().getParameters().get('Mode');
        if(modeStr == 'Edit') {
            isEdit = true;
        } else {
            isEdit = false;
        }
        
        if(acc != null && acc.Id != null) {
            acc = [Select Id, Name, AccountNumber from Account where Id =: acc.Id];
            
        }
    }

}