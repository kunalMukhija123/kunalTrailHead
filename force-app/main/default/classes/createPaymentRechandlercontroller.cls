public class createPaymentRechandlercontroller{

    public static void onAfterInsert(List<opportunity> oppList) {
        system.debug('-------OppList---- ' +oppList);
        List<payment__c> payList = new List<payment__c>();
        system.debug('------oppList---- ' +oppList);
        for(Opportunity opp : oppList){
            if(opp.StageName == 'Closed Won'){
                payment__c pay = new payment__c();
                pay.Name = opp.Name;
                pay.Amount__c = opp.Amount;
                pay.Date__c = opp.CloseDate;
                pay.OpportunityName__c = opp.Id;
                payList.add(pay);    
            }
        }
        insert payList;
    }

    public static void onAfterUpdate(Map<Id,opportunity> OldMap, Map<Id,opportunity> NewMap) {
        List<payment__c> payList = new List<payment__c>();
        Map<Id,payment__c> payMap = new Map<Id,payment__c>();
        
        for(Opportunity opp : NewMap.values()){
            if(opp.StageName == 'Closed Won' && Oldmap.get(opp.Id).StageName != Newmap.get(opp.Id).StageName){
                payment__c pay = new payment__c();
                pay.Name = opp.Name;
                pay.Amount__c = opp.Amount;
                pay.Date__c = opp.CloseDate;
                pay.OpportunityName__c = opp.Id;
                payList.add(pay);    
            }else{
                payMap = new Map<Id,payment__c>([select Id from payment__c where opportunityName__r.Id =: opp.Id]);
                for(ID payId : payMap.keyset()){
                    payMap.get(payId).Name = Newmap.get(opp.Id).Name; 
                    payMap.get(payId).Amount__c = Newmap.get(opp.Id).Amount;   
                    payMap.get(payId).Date__c = Newmap.get(opp.Id).CloseDate;    
                }
                
            }
        }
        upsert payList; 
        update payMap.values(); 
    }
    
}