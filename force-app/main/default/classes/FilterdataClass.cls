public with sharing class FilterdataClass {

    List<contact> lsttest = new List<contact>();

    string sQuery='';
    public List<contact> getRecords() {
    if(hdnVal=='ALL')
    {
        sQuery='select Id,name,Email , phone from contact';
    }
    else
    {
       sQuery='select Id,name,Email , phone from contact where name LIKE \''+hdnVal+'%\'';
       system.debug('****** sQuery is ******'+sQuery);
     }
    lsttest = database.query(sQuery);
    return lsttest;
    }


    public PageReference showValApex() {
        system.debug('******hdnVal******'+hdnVal);
        return null;
    }

    public String hdnVal { get; set; }
}