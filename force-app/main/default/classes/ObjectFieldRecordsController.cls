public class ObjectFieldRecordsController {


    //Map having all  object present in this organization
    Map < String, Schema.SObjectType > gd = Schema.getGlobalDescribe();
    //List to be set on selected list and have all object present in the organization
    public List < SelectOption > listOfObject {
        get;
        set;
    }
    //Varible use to store selected value from selectedList of object
    public String objectName {
        get;
        set;
    }
    //Variable of type SObject which can hold any type of object and is used to hold object obtained from value of ojbect's selected list
    Schema.SObjectType sobj = gd.get(objectName);
    //Map to hold fields ofselected object
    Map < String, Schema.SObjectField > fieldsMap;
    //Variable to hold selected value from selected list of fields
    public List < String > stringfieldName {
        set;
        get;
    }
 
    //Constructor to initilize class variables shown on page after class loaded
    public ObjectFieldRecordsController() {
        
        
        stringfieldName = new List < String > ();
        
        listOfObject = new List < SelectOption > ();
        List < Schema.SObjectType > gd1 = gd.Values();
        listOfObject.add(new SelectOption('', '--None--'));
        //This for loop adds object name to the object's selected list
        for (Schema.SObjectType f: gd1)
            listOfObject.add(new SelectOption(f.getDescribe().getLocalName(), f.getDescribe().getLabel()));
        listOfObject.sort();
    }
    //Select-Option type list to return fields of selected object
    public List < SelectOption > getFieldName() {
        List < SelectOption > fieldList = new List < SelectOption > ();
        fieldList.add(new selectOption('','--Select Field---'));
        if (objectName != null && objectName != '') {
            sobj = gd.get(objectName);
            //Variable to hold all properties of sobj like-fields.label createable etc
            Schema.DescribeSObjectResult all = sobj.getDescribe();
            fieldsMap = new Map < String, Schema.SObjectField > ();
            //Adding fields to the fieldsMap
            fieldsMap = all.fields.getMap();
            // This for loop add the field api name as a key and field label as value into field list
            for (Schema.SObjectField fieldName: fieldsMap.Values()) {
                if (fieldName.getDescribe().getName() != 'id')
                    fieldList.add(new SelectOption(fieldname.getDescribe().getName(), fieldName.getDescribe().getLabel()));
            }
            fieldList.sort();
        }
        return fieldList;
    }
   
}