public class PaginationOffset {

    public List < PriceBookWrapper > ConWrapList {get; set;}
    public List < PricebookEntry > PriceBookEntry {get;set;}
    // public List<PricebookEntry> Pbe{get;set;}
    public List < opportunityLineItem > OppLineItem {get;set;}
    public OpportunityLineItem opp {get;set;}
    public string oppID {get;set;}
    public boolean Show_Hide {get;set;}
    List < PricebookEntry > RecordTOShow;
    public opportunity oppObj {get;set;}
    public String queryString {get;set;}  

    private integer counter = 0;
    private integer list_size = 5;
    public integer total_size;

    public PaginationOffset() {
        ConWrapList = new List < PriceBookWrapper > ();
        Show_Hide = false;
        oppID = ApexPages.currentPage().getParameters().get('id');
        OppLineItem = new List < opportunityLineItem > ();

        oppObj = [SELECT PriceBook2Id, Name FROM Opportunity WHERE id =: oppID];
     // total_size = [select count() from PricebookEntry WHERE PriceBook2Id =: oppObj.PriceBook2Id];
        system.debug('--------Total Size------'+total_size);
        alpha ='All';
        SortList();
        system.debug('-------------wrapper List Data---------- ' + ConWrapList);   
    }

    public class PriceBookWrapper {

        public Boolean isSelected {get;set;}
        public PriceBookEntry conObj {get;set;}

        public PriceBookWrapper(priceBookEntry conObj) {
            this.conObj = conObj;
            isSelected = false;
        }
    }

    public void SelectRecord() {

        for (PriceBookWrapper c: conWrapList) {
            if (c.isSelected == true) {
                OppLineItem.add(new OpportunityLineItem(opportunityId = oppID, priceBookEntry = c.conObj, unitPrice = c.conObj.unitPrice));
                c.isSelected = false;
            }
            Show_Hide = true;
            system.debug('--------OppLineItem list data------'+OppLineItem);
        }
    }

    public pageReference save() {
        for (integer i = 0; i < OppLineItem.size(); i++){
            OppLineItem[i].priceBookEntryId = OppLineItem[i].priceBookEntry.Id;
        }            
        insert OppLineItem;
        return new PageReference('/' + oppID);
    }

    public pageReference Cancel1() {
        PageReference pageRef = new PageReference('/' + oppID);
        pageRef.setRedirect(true);
        return pageRef;
    }

    public void Cancel() {
        OppLineItem.clear();
        Show_Hide = false;
    }

    Public string alpha {get;set;}

    public void SortList() {
        
        string searchTerm = alpha + '%';
        RecordTOShow = new List < PricebookEntry > ();
        conWrapList = new List < PriceBookWrapper > ();
        if (alpha == 'All') {
            total_size = [select count() from PricebookEntry WHERE PriceBook2Id =: oppObj.PriceBook2Id];
        //  RecordToShow = [SELECT Product2.Name, ProductCode, unitPrice FROM PricebookEntry WHERE PriceBook2Id =: oppObj.PriceBook2Id order by ProductCode limit: list_size offset: counter];
            queryString = 'SELECT ';
            for(Schema.FieldSetMember fld :SObjectType.PriceBookEntry.FieldSets.PriceBookEntryFS.getFields()) {
                 queryString +=  fld.getFieldPath() + ',';
            }
            queryString = queryString.removeEnd(',');
        //  String proId = oppObj.PriceBook2Id;
        //  queryString += ' from PriceBookEntry WHERE PriceBook2Id =: proId order by ProductCode limit: list_size offset: counter';
            queryString += ' from PriceBookEntry WHERE PriceBook2Id = \'' + oppObj.PriceBook2Id + '\' order by ProductCode limit: list_size offset: counter';
            system.debug('--------FORMED QUERY --------'+queryString);
            RecordToShow = Database.query(queryString);    
            
            system.debug('-------Data in case of all------'+RecordToShow);
            system.debug('-------CON WRAP LIST DATA------'+conWrapList);
        } else {
            // RecordToShow.clear();
            total_size = [select count() from PricebookEntry WHERE PriceBook2Id =: oppObj.PriceBook2Id AND Product2.Name like: searchTerm];
            system.debug('----- Total Number of records in case of alpha-----'+total_size);
        //  RecordToShow = [select Product2.Name, ProductCode, unitPrice from PriceBookEntry where PriceBook2Id =: oppObj.PriceBook2Id AND Product2.Name like: searchTerm order by ProductCode limit: list_size offset: counter];
            queryString = 'SELECT ';
            for(Schema.FieldSetMember fld :SObjectType.PriceBookEntry.FieldSets.PriceBookEntryFS.getFields()) {
                 queryString +=  fld.getFieldPath() + ',';
            }
            queryString = queryString.removeEnd(',');
            queryString += ' from PriceBookEntry WHERE PriceBook2Id = \'' + oppObj.PriceBook2Id + '\' AND Product2.Name like: searchTerm order by ProductCode limit: list_size offset: counter';
            system.debug('--------FORMED QUERY --------'+queryString);
            RecordToShow = Database.query(queryString);
            
            system.debug('-------Data in case of all------'+RecordToShow);
            system.debug('-------CON WRAP LIST DATA------'+conWrapList);
            system.debug('-------Data in case of Alpha------'+RecordToShow);
        }
        
        if (RecordToShow != Null && RecordToShow.size() > 0) {
            for (PriceBookEntry rec: RecordToShow) {
                conWrapList.add(new PriceBookWrapper(rec));
            }
            system.debug('-------CON WRAP LIST DATA------'+conWrapList);
        } 
    }            
    
    public void counterReset(){
        Counter = 0;
        sortList();
    }

    public Integer getTotal_size() {
        return total_size;
    }

    public Integer getPageNumber() {
        return counter / list_size + 1;
    }

    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size / list_size + 1;
        } else {
            return (total_size / list_size);
        }
    }

    public void Beginning() {
        counter = 0;
        SortList();
    }

    public void Previous() {
        counter = counter - list_size;
        SortList();
    }

    public void Next() {
        counter = counter + list_size;
        SortList();
    }

    public void End() {
        counter = total_size - math.mod(total_size, list_size);
        SortList();    
    }

    public Boolean getDisablePrevious() {
        if (counter > 0) {
            return false;
        } else {
            return true;
        }
    }

    public Boolean getDisableNext() {
        if (counter + list_size < total_size) {
            return false;
        } else {
            return true;
        }
    }

}