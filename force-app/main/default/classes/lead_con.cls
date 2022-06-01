public class lead_con {

  public String val {get;set;}
  public List<String> AllLabels{get;set;}
  public List<String> AllLabels_Sel_obj{get;set;}
  
  public List<SelectOption> getName()
  {
    List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();     
    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption( ' ' ,'---None---'));
    for(Schema.SObjectType f : gd)
    {  
       string Name = f.getDescribe().getName();
       if(Name != null && Name.contains('__c')){
    //   options.add(new SelectOption(f.getDescribe().getLabel(),f.getDescribe().getLabel()));
        options.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel()));
       }
    }
    system.debug('-----list size----- ' +options.size());
    return options;
  }
  
  public string upd_oppName {get; set;}
//  List<SObject> sobj = new List<SObject>();
  public List<Mapping__c> map_rec {get; set;}

  public void processSelected(){
 //   selectedLeads = new List<Lead>();
    for(wrapLead wrapLeadObj : wrapLeadList) {
        if(wrapLeadObj.selected == true) {
            if(wrapLeadObj.LD.Status != 'Closed - Converted'){
                Database.LeadConvert lc = new database.LeadConvert();
                system.debug('--32-----wrapLeadObj.LD.Id ------- ' +wrapLeadObj.LD.Id);
                lc.setLeadId(wrapLeadObj.LD.Id);
                lc.ConvertedStatus = 'Closed - Converted';
                
                system.debug('---32----wrapLeadObj.create_opp------- ' +wrapLeadObj.create_opp);
                upd_oppName = wrapLeadObj.LD.Company;
                system.debug('---34 ----upd_oppName --- ' +upd_oppName);
                lc.setOpportunityName(upd_oppName);
                lc.setDoNotCreateOpportunity(wrapLeadObj.create_opp);
                Database.LeadConvertResult lcr = Database.convertLead(lc);                
                System.assert(lcr.isSuccess());
                
                
                
            }
        }
    }
  }
  
//  public string source ; 
//  Public string Destination;
  
  public void LeadToCustomObjRec(){
      system.debug('-----sobjectName----- ' +sobjectName);
    string upt_source = '';
    string upt_Des = '';
    Map<String,String> sourceToDes = new Map<String,String>(); 
    system.debug('-----sobj Name--- ' +sobjectName);
    List<Mapping__c> sourceField = [Select Source_Field__c from Mapping__c where Copy_to_Master__c =: sObjectName];
    for(Mapping__c Src : sourceField){
        string source = Src.source_Field__c;
        upt_source = source +','+ upt_source;
    }
    system.debug('--52---source Val---- ' +upt_source);
    
    List<Mapping__c> DestinationField = [Select Destination_Field__c from Mapping__c where Copy_to_Master__c =: sObjectName];
    for(Mapping__c Des : DestinationField){
        string Destination = Des.Destination_Field__c ; 
        upt_Des = Destination +','+ upt_Des ;
    }
    system.debug('--59---Desti Val---- ' +upt_Des);
    
    List<string> Source_List = upt_source.split(',');
    system.debug('--62--source_List----- ' +source_List);
    List<string> Desti_List = upt_Des.split(',');
    system.debug('--64--Des_List----- ' +Desti_List);
    
    integer I=0;
    for(String st : Source_List){
        sourceToDes.put(st , Desti_List.get(I));
        I++;    
    }
    system.debug('--71---map data---- ' +sourceToDes);
    system.debug('-------upt_source----- ' +upt_source);
    string qry_src_data = upt_source.removeEnd(',');
    system.debug('--------' +'SELECT '+qry_src_data+' FROM Lead');
    List<sObject> SourceData = Database.query('SELECT '+qry_src_data+' FROM Lead');
    system.debug('----75----source data---- ' +SourceData);
    
    List<sobject> DestiData =  new List<sobject>();
    string str_val = string.valueof(sObjectName);
    system.debug('---str_val--- ' +str_val);
    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
    Schema.SObjectType sg = gd.get(str_val);
    for(sobject st : SourceData){
        Sobject s = sg.newSobject();
        for(string key : sourceToDes.keyset()){
            s.put(sourceToDes.get(key) , st.get(key));
        }
       DestiData.add(s); 
    }
    system.debug('-----89--DestiData List----- ' +DestiData);
    insert DestiData;
    
    /*  system.debug('-----selected Mapping-- ' +map_rec);
      for(Mapping__c mm : map_rec){
          source = mm.source_Field__c;
          Destination = mm.Destination_Field__c;
          List<sObject> sobjListSource = Database.query('SELECT '+source+' FROM Lead');
          system.debug('--61---sobjList----- ' +sobjListSource);
          
      }  */
      
  }
  
  public List<string> MapTypeVal1 {get; set;}
  public String mapParentChildrenJSON2 {get;set;}
  public String mapParentChildrenJSON4 {get;set;}
  public Map<string,Schema.DisplayType> mapType1 {get;set;}
  public Map<String, Schema.SObjectField> fieldMap {get; set;}
  public string sObjectName;
  public void find(){
    system.debug('-----selected obj----  ' +val);
    String type= val;
    sObjectName = type;
    system.debug('---55--sobject Name--- ' +sobjectName);

     
    List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values(); 
    system.debug('-----gd list val----- ' +gd);   
    Map<String,String> objName = new Map<String,String>();
    for(Schema.SObjectType f : gd){
        system.debug('---f val---- ' +f);
        if(f.getDescribe().isCustom())
        {
        objName.put(f.getDescribe().getName(),f.getDescribe().getLabel());
        }
    }
    System.debug('----140------Object Names------ ' +objName);
    system.debug('----141-------object Map key set---- ' +objName.keyset());
    system.debug('----142-------object Map key set---- ' +objName.values());
            
    if(objName.keyset().contains(sObjectName)){
        system.debug('----contains-----');
        //string key_val = objName.get(sObjectName);
        string key_val = string.valueof(sobjectName);
        system.debug('----key_val------ ' +key_val);
        
        mapType1 = new Map<string,Schema.DisplayType>();
        AllLabels_Sel_obj = new List<String>();
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get(key_val);
        system.debug('-------lead schema val ---- ' +leadSchema);    
   //     if(leadSchema.getDescribe().isCustom()){
            system.debug('----28-----lead schema---- ' +leadSchema);
        //    Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
          fieldMap = leadSchema.getDescribe().fields.getMap();
          system.debug('---80----fieldMap val----- ' +fieldMap);  
            
            
        for (String fieldName: fieldMap.keySet()) {
            System.debug('Field API Name='+fieldName);    // list of all field API name
            if(fieldMap.get(fieldName).getDescribe().iscreateable() || fieldMap.get(fieldName).getDescribe().isupdateable()){
                AllLabels_Sel_obj.add(fieldMap.get(fieldName).getDescribe().getLabel());    //It provides to get the object fields label.
                AllLabels_Sel_obj.sort();
                MapType1.put(fieldMap.get(fieldName).getDescribe().getLabel(), fieldMap.get(fieldName).getDescribe().getType());
            }
        }
            
           
        system.debug('-----New Map data ---- 186----' +MapType1);
        system.debug('-----mapType data----- ' +mapType1);

        mapParentChildrenJSON2 = JSON.serialize(mapType1);
        system.debug('---176---JSON Parse data----- ' +mapParentChildrenJSON2); 
        
        MapTypeVal1 = new List<string>();
        for(string val : mapType1.keyset()){
            
            system.debug('----val data---- ' +val);
            val = val + ':' + mapType1.get(val);
            system.debug('--195-----val data--- ' +val);
         /*   if(wrapMapList == null){
                wrapMapList = new List<wrapMap>();
                wrapMapList.add(new wrapMap(val));
            }
            system.debug('-200----wrapMapList data---- ' +wrapMapList);  */
            MapTypeVal1.add(val);
            system.debug('------new list data--- ' +MapTypeVal1);
        }
        mapParentChildrenJSON4 = JSON.serialize(MapTypeVal1);
        system.debug('---193---JSON Parse data----- ' +mapParentChildrenJSON4); 
   //     }         
    }      
    
  }
  
  Map<Id,Id> Acc_conMap {get;set;}
  public String mapParentChildrenJSON {get;set;}
  public String mapParentChildrenJSON1 {get;set;}
  public String mapParentChildrenJSON3 {get;set;}
  public string jsonGen {get;set;}
 // public string jsonGen1 {get;set;}
  public List<String> myList {get; set;}
 
  public List<string> MapTypeVal {get; set;}
  
  public Map<string,Schema.DisplayType> mapType {get;set;}
  public Map<String, Schema.SObjectField> fieldMap1 {get; set;}
//  public Map<string, DescribeFieldResult> fMap1 {get; set;}
   public lead_con(){
   
    Map<Id, List<Contact>> mapAcctIdContactList = new Map<Id, List<Contact>>();
    List<Contact> listContact = [SELECT Id, FirstName, AccountId FROM Contact];
    
    for(Contact con : listContact) {
        if(String.isNotBlank(con.AccountId)){
            if(!mapAcctIdContactList.containsKey(con.AccountId)) {
                mapAcctIdContactList.put(con.AccountId, new List<Contact>());
            }
            mapAcctIdContactList.get(con.AccountId).add(con);
        }
    }
    mapParentChildrenJSON = JSON.serialize(mapAcctIdContactList);
    system.debug('------JSON Parse data----- ' +mapParentChildrenJSON); 
    
    JSONGenerator gen = JSON.createGenerator(false);
    if(mapAcctIdContactList == null){
            jsonGen = '';         
        }else{
             
            gen.writeStartArray();
             
            for(Id mapID : mapAcctIdContactList.keyset()){
                for(contact con : mapAcctIdContactList.get(mapID)){
                       
                gen.writeStartObject();
                     
                    gen.writeStringField('conID', con.Id);
                    gen.writeStringField('accID', con.accountId);
                    gen.writeEndObject();
                }
            }
             
        gen.writeEndArray();
        jsonGen = gen.getAsString();   
        system.debug('--------JSON GEN Data------- ' +jsonGen);
  //      myList = (List<String>)System.JSON.deserialize(mapParentChildrenJSON , List<String>.class);
  //      system.debug('-----myList data------ ' +myList);
       }
       

        map_rec = new List<Mapping__c>([select Id , Source_Field__c , Destination_Field__c , Copy_to_Master__c from Mapping__c]);
        system.debug('------map_rec----- ' +map_rec);
        
        for(Mapping__c mm : map_rec){
            system.debug('--150----mm rec---- ' +mm);
            system.debug('----mm first----' +mm.source_Field__c);
            system.debug('----mm second Field---- ' +mm.Destination_Field__c);
        }
       
 /*   Map<Id,Id> Acc_conMap = new Map<Id,Id>();
    List<contact> conIDs = new List<contact>([Select Id , accountId from contact where accountId =: '0012800001Otckh']);
    system.debug('------con IDs list data----- ' +conIDs);
    for(contact cId : conIDs){
        Acc_conMap.put(cId.accountId, cId.id);
        system.debug('------map data----- ' +Acc_conMap);
    }
    system.debug('------map data----- ' +Acc_conMap);
   
    mapParentChildrenJSON = JSON.serialize(Acc_conMap);
    system.debug('------JSON Parse data----- ' +mapParentChildrenJSON);   */  
   
   
    String type='Lead';
    mapType = new Map<string,Schema.DisplayType>();
    AllLabels = new List<String>();
    Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    Schema.SObjectType leadSchema = schemaMap.get(type);
    fieldMap1 = leadSchema.getDescribe().fields.getMap();
    system.debug('--------field map data----- ' +fieldMap1);
    system.debug('-------leadSchema.getDescribe()=========' +leadSchema.getDescribe());
    system.debug('----------field data------ '+leadSchema.getDescribe().fields);
    
    Map<String,List<String>> objName = new Map<String,List<String>>();
    List<string> objMap_val = new List<string>();
    List<Schema.SObjectField> objMap_val1 = new List<Schema.SObjectField>();
    List<Schema.DisplayType> objMap_val2 = new List<Schema.DisplayType>();
    system.debug('---------- fieldMap keyset ------ ' +fieldMap1.keyset());
    system.debug('---------- fieldMap keyset values------ ' +fieldMap1.values());
    
    for (String fieldName: fieldMap1.keySet()) {
        system.debug('--102---fieldMap.get(fieldName)-------- ' +fieldMap1.get(fieldName) +'---------'+fieldMap1.get(fieldName) +'--------' +fieldMap1.get(fieldName).getDescribe().getType()+'----' +fieldMap1.get(fieldName).getDescribe().getLabel());
        
    }
    
    
    for (String fieldName: fieldMap1.keySet()) {
        System.debug('Field API Name='+fieldName);    // list of all field API name
        if(fieldMap1.get(fieldName).getDescribe().iscreateable() || fieldMap1.get(fieldName).getDescribe().isupdateable()){
            AllLabels.add(fieldMap1.get(fieldName).getDescribe().getLabel());    //It provides to get the object fields label.
            AllLabels.sort();
          //  mapType.put(fieldName , fieldMap1.get(fieldName).getDescribe().getType());
            mapType.put(fieldMap1.get(fieldName).getDescribe().getLabel(), fieldMap1.get(fieldName).getDescribe().getType());
            system.debug('---306--mapType data----' +mapType +'-------map Type Size----- '+ +mapType.size());
        }        
    } 
    system.debug('-----mapType data----- ' +mapType);
    
    mapParentChildrenJSON1 = JSON.serialize(mapType);
    system.debug('---310---JSON Parse data----- ' +mapParentChildrenJSON1); 
    
    
    MapTypeVal = new List<string>();
    for(string val : mapType.keyset()){
        
        system.debug('----val data---- ' +val);
        val = val + ':' + mapType.get(val);
        system.debug('--195-----val data--- ' +val);
        if(wrapMapList == null){
            wrapMapList = new List<wrapMap>();
            wrapMapList.add(new wrapMap(val));
        }
        system.debug('-200----wrapMapList data---- ' +wrapMapList);
        MapTypeVal.add(val);
        system.debug('------new list data--- ' +MapTypeVal);
    }
    mapParentChildrenJSON3 = JSON.serialize(MapTypeVal);
    system.debug('---328---JSON Parse data----- ' +mapParentChildrenJSON3); 
        
    Set<String> fieldSet = fieldMap1.keySet();
    system.debug('------fieldSet - -- - - ' +fieldSet +'-----size----' +fieldset.size());
    
    
    Map<string, DescribeFieldResult> fMap1 = new Map<string, DescribeFieldResult>();
    for(String s:fieldSet)
    {
        system.debug('-------value of s as key------ ' +s);
        SObjectField fieldToken = fieldMap1.get(s);
        system.debug('-----field name----  ' +fieldToken);
        DescribeFieldResult selectedField = fieldToken.getDescribe();
        system.debug('-------selectedField result describe----- ' +selectedField);
        fmap1.put(s,selectedField);
        system.debug('----map data----- ' +fmap1);
    }
    system.debug('--137--map data----- ' +fmap1);
    
    
    
    
    if(wrapLeadList == null) {
        wrapLeadList = new List<wrapLead>();
        for(Lead L: [select Id, FirstName , LastName, Name, status, company FROM Lead  Where status != 'Closed - Converted']) {
            wrapLeadList.add(new wrapLead(L));
        }
    }     
  }  
  
  public String jqueryVal{get;set;}
    public String enteredText1{get;set;}
    public String enteredText2{get;set;}

    public void echoVal()
    {
     jqueryVal = 'You have entered : 1 - '+enteredText1+' 2 -'+enteredText2;
     system.debug('--jqueryVal--369----- ' +jqueryVal);
     system.debug('-----+enteredText1----' +enteredText1);
     system.debug('-----+enteredText2----' +enteredText2);
     
     
     Schema.DisplayType src_Type = mapType.get(enteredText1);
     system.debug('-----src_type---- ' +src_Type);
     
     Schema.DisplayType Des_Type = mapType1.get(enteredText2);
     system.debug(' -----des_type--- ' +Des_Type);
     
     
/*   for(ID id : mapType.keyset()){
         if(enteredText1 == id){
             Schema.DisplayType src_Type = mapType.get(id);
             system.debug('-----src_type---- ' +src_Type);
         }
         
     }
     for(ID id : mapType1.keyset()){
     if(enteredText2 == id){
         Schema.DisplayType Des_Type = mapType.get(id);
         system.debug(' -----des_type--- ' +Des_Type);
     }
         
     }     */
    }
   
   
  public void callBatch()
  {
   batchMassLeadCon ld_con = new batchMassLeadCon();
   Database.executeBatch(ld_con);
  }     
      
  public boolean displayPopup {get; set;}     
    
  public void closePopup() {        
      displayPopup = false;    
  }     
  
  public void showPopup() {        
      displayPopup = true;    
  }   
  
  public List<wrapLead> wrapLeadList {get; set;}
//  public List<Lead> selectedLeads{get;set;}
//  public List<Lead> creLead_Opp_List{get;set;}
   
  public class wrapLead {
      public Lead LD {get; set;}
      public Boolean selected {get; set;}
      public Boolean create_opp {get; set;}
    
      public wrapLead(Lead L) {
          LD = L;
          selected = false;
          create_opp = false;
      }
  }
  
  public List<wrapMap> wrapMapList {get; set;}
  public class wrapMap {
    //  public Lead LD {get; set;}
      public string key {get; set;}
      public string val {get; set;}
    
      public wrapMap(string a) {
        //  LD = L;
          key = '';
          val = '';
      }
  }
  
 
    
}