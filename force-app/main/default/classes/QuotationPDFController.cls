public class QuotationPDFController{
    public list<OpportunityLineItem> lstOfQuoteLineItems{get; set;}

    public QuotationPDFController(){
        lstOfQuoteLineItems = new List<OpportunityLineItem>([select Id, Product2Id, unitPrice, Quantity, TotalPrice, Product2.Name from OpportunityLineItem where opportunityId= '0060K00000Rtj87'  ]);
        System.debug('----QL items-->>>......'+lstOfQuoteLineItems);
    }
}