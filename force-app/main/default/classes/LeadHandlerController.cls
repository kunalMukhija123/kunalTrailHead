public class LeadHandlerController {

    public static void onBeforeInsert(List<Lead> LeadList) {
        System.debug('---Lead List--->>> ' +LeadList);
        Set<Id> leadIDs = new Set<Id>();
        Set<Id> ConIDs = new Set<Id>();
        List<Lead> lstLead = new List<Lead>([Select Id, Name from lead]);      
        System.debug('----lst Lead rec--->>> ' +lstLead);  
        
        Map<String,Lead> MapLeadIdToLeadObj = new Map<String, Lead>();
        for(Lead objLead : lstLead){
            MapLeadIdToLeadObj.put(objLead.Name,objLead);
        }
        
        List<Contact> lstContact = new List<Contact>([Select Id, Name from Contact]);      
        System.debug('----lst Lead rec--->>> ' +lstLead); 
        Map<String, Contact> MapConIdToConObj = new Map<String,Contact>();
        for(contact objCon : lstContact){
            MapConIdToConObj.put(objCon.Name, objCon);
        }
        
        for(Lead objLead : LeadList){
            if(objLead.Name != null && MapLeadIdToLeadObj != null){
                if(MapLeadIdToLeadObj.keyset().contains(objLead.Name)){
                    leadIDs.add(objLead.Name);
                }
            }
            
            if(objLead.Name != null && MapConIdToConObj != null){
                if(MapConIdToConObj.keyset().contains(objLead.Name)){
                    ConIDs.add(objLead.Name);
                }
            }
        }
        
        List<Lead> upd_lstLead = new List<Lead>([Select Id,Name from Lead where ID in : leadIDs order by CreatedDate desc limit 1]);
        List<Contact> upd_lstContact = new List<Contact>([Select Id,Name from Contact where ID in : ConIDs order by CreatedDate desc limit 1]);
        
        for(Lead objLead : LeadList){
            for(Lead up_objLead : upd_lstLead){
                if(objLead.Name == up_objLead.Name){
                    objLead.Lead__c = up_objLead.Id;
                }
            }
            
            for(Contact up_objCon : upd_lstContact){
                if(objLead.Name == up_objCon.Name){
                    ObjLead.Contact__c = up_objCon.Id;
                }
            }
        }
        
     /* try{
            if(LeadList.size() != null){
               
            }
        }catch(DMLException e){
            System.debug('-----Exception ------>>>> ' +e);
        }  */
        
    }
       
    public static void onBeforeUpdate(List<Lead> LeadList, Map<Id, Lead> OldMap) {
                   
    }  
    


}