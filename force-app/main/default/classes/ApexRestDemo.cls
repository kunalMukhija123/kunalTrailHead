@RestResource(urlmapping='/GetOpportunityRecord/*') 
global class ApexRestDemo { 
    @HttpGet 
    global static void doGet() { 
        doVoid(); 
    } 
    
    @HttpPost 
    global static void doPost() { 
        doVoid(); 
    } 
    
    public static void doVoid(){ 
        RestRequest req = RestContext.request; 
        RestResponse res = RestContext.response; 
        Map<String, String> parameter = req.params; 
        String jsonString = '';
        String accName = parameter.get('clientName'); 
        
        if(accName == null || accName == '') {
            jsonString = '{"Error": "Client name is missing"}';
            res.addHeader('Content-Type', 'application/json'); 
            res.responsebody=blob.valueof(jsonString); 
        }else{
            Set<Id> AccIds = new Set<Id>();
            for(Account objAcc : [select Id from Account where Name =: accname]){
                AccIds.add(objAcc.Id);
            }
            
            List<opportunity> lstOpportunity = new List<opportunity>([Select Id, AccountId, Amount, CloseDate, Last_meeting_call_date__c, account.Description, account.Name, account.BillingStreet, account.BillingCity, account.BillingState, account.BillingPostalCode, account.BillingCountry from Opportunity where AccountId IN: AccIds order by closeDate desc limit 1]);
            if(lstOpportunity != null && lstOpportunity.size() > 0) {
                
                JSONGenerator gen = JSON.createGenerator(true);
                // gen.writeString('Opportunity Data:');
                // gen.writeStartArray();
                for(Opportunity oppObj: lstOpportunity){
                    gen.writeStartObject();
                    // gen.writeStringField('Opportunity Id',oppObj.Id);
                    gen.writeNumberField('Last Sale Amount',oppObj.Amount);
                    gen.writeDateField('Close Date of last sale',oppObj.CloseDate);
                    gen.writeDateField('Last Meeting/Call Date',oppObj.Last_meeting_call_date__c);
                    //  gen.writeStringField('Account ID',oppObj.AccountId);
                    String ClientAddress = oppObj.account.BillingStreet +','+ oppObj.account.BillingCity +','+ oppObj.account.BillingState +','+ oppObj.account.BillingPostalCode +','+ oppObj.account.BillingCountry;
                    if(ClientAddress != null){
                        gen.writeStringField('Contact of a client ',ClientAddress);
                    }
                    // gen.writeStringField('Client Name',oppObj.account.Name);
                    gen.writeStringField('Note for client ',oppObj.account.Description);
                    gen.writeEndObject();
                }
                // gen.writeEndArray();
                
                jsonString = gen.getAsString();
                res.addHeader('Content-Type', 'application/json'); 
                res.responsebody=blob.valueof(jsonString); 
            }else{
                jsonString = '{"Error": "Information not found"}';
                res.addHeader('Content-Type', 'application/json'); 
                res.responsebody=blob.valueof(jsonString); 
            }
        }              
    }
}