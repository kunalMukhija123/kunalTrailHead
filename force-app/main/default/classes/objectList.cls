public class objectList{
  public String val {get;set;}
 
  public List<SelectOption> getName()
  {
    List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();     
    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('', '--None--'));
    for(Schema.SObjectType f : gd)
    {
      options.add(new SelectOption(f.getDescribe().getLabel(),f.getDescribe().getLabel()));
      options.sort();
    }
    return options;
   }
}