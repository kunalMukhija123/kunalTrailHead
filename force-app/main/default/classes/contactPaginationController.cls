public class contactPaginationController{
 
 public String FirstName {get; set;}
    public String LastName {get; set;}
    public String Email {get; set;}
    public String Phone {get; set;}
    public String AccountId {get; set;}
    public contact co {get;set;}
    public String contactId {get;set;}
 
 //variable used in page.
 Public Integer size{get;set;}
 Public Integer noOfRecords{get; set;}
 public List<SelectOption> paginationSizeOptions{get;set;}
 public static final Integer QUERY_LIMIT = 10000;
 public static final Integer PAGE_SIZE = 5;
 
 public List <WrapperClass> wrapperRecordList{get;set;}
 public List <WrapperClass> wrapperRecordList1{get;set;}
 public List <WrapperClass> wrapperRecordList2{get;set;}
 
 Map<Id, WrapperClass> mapHoldingSelectedRecords{get;set;}
 
 //constructor calling init method.
 public contactPaginationController(){
   co = new contact();
   wrapperRecordList2 = new List<wrapperClass>();
   mapHoldingSelectedRecords = new Map<Id, WrapperClass>();
   init();
 
 }
 
//Init method which queries the records from standard set controller.
 public void init() {
 wrapperRecordList = new List<WrapperClass>();
 wrapperRecordList1 = new List<WrapperClass>();
 for (Contact cont : (List<Contact>)setCon.getRecords()) {
 if(mapHoldingSelectedRecords != null && mapHoldingSelectedRecords.containsKey(cont.id)){
 wrapperRecordList.add(mapHoldingSelectedRecords.get(cont.id));
 
 }
 else{
   wrapperRecordList.add(new WrapperClass(cont, false));
 }  
 }
 }
 
 public void delContact(){
       // wrapperRecordList = new List<wrapperClass>();
        wrapperRecordList1 = new List<wrapperClass>();
       // wrapperRecordList2 = new List<wrapperClass>();
       // wrap_ConList2 = new List<wrapperClass>();
        
        system.debug('-----del rec------ ' +contactId);
        if(contactId != null){
            for(wrapperclass wc : wrapperRecordList){
                system.debug('------wc rec---- ' +wc);
                system.debug('------wc rec---- ' +wc.contactRecord);
                if(wc.contactRecord.Id != contactId){
                   wrapperRecordList1.add(wc);
                }else{
                   wrapperRecordList2.add(wc);
                }
            }
            wrapperRecordList.clear();
            wrapperRecordList = wrapperRecordList1;
            
            system.debug(' ----Not del list rec---- ' +wrapperRecordList1);
            system.debug(' ----to del list rec---- ' +wrapperRecordList2);
        }   
        
    }
 
 /** Instantiate the StandardSetController from a query locater*/
 public ApexPages.StandardSetController setCon {
 get {
 if(setCon == null) {
   setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id,Name, Email, Phone FROM Contact LIMIT : QUERY_LIMIT ]));
 
   // sets the number of records to show in each page view
   setCon.setPageSize(PAGE_SIZE);
 }
   return setCon;
 }
 set;
 }
 
 /** indicates whether there are more records after the current page set.*/
 public Boolean hasNext {
 get {
   return setCon.getHasNext();
 }
 set;
 }
 
 /** indicates whether there are more records before the current page set.*/
 public Boolean hasPrevious {
 get {
   return setCon.getHasPrevious();
 }
 set;
 }
 
 /** returns the page number of the current page set*/
 public Integer pageNumber {
 get {
   return setCon.getPageNumber();
 }
 set;
 }
 
 /** return total number of pages for page set*/
   Public Integer getTotalPages(){
     Decimal totalSize = setCon.getResultSize();
     Decimal pageSize = setCon.getPageSize();
     Decimal pages = totalSize/pageSize;
     return (Integer)pages.round(System.RoundingMode.CEILING);
 }
 
 /** returns the first page of the page set*/
 public void first() {
   updateSearchItemsMap();
   setCon.first();
   init();
 }
 
 /** returns the last page of the page set*/
 public void last() {
   updateSearchItemsMap();
   setCon.last();
   init();
 }
 
 /** returns the previous page of the page set*/
 public void previous() {
   updateSearchItemsMap();
   setCon.previous();
   init();
 }
 
 /** returns the next page of the page set*/
 public void next() {
   updateSearchItemsMap();
   setCon.next();
   init();
 }
 
 //This is the method which manages to remove the deselected records, and keep the records which are selected in map.
 private void updateSearchItemsMap() {
 for(WrapperClass wrp : wrapperRecordList){
  if(wrp.isSelected){
     mapHoldingSelectedRecords.put(wrp.contactRecord.id, wrp);
  }
  if(wrp.isSelected == false && mapHoldingSelectedRecords.containsKey(wrp.contactRecord.id)){
     mapHoldingSelectedRecords.remove(wrp.contactRecord.id);
  }
 }
 }
 
 //wrapper class being used for checkbox showing.
 public class WrapperClass {
 public Boolean isSelected {get;set;}
 public Contact contactRecord {get;set;}
 public WrapperClass(Contact contactRecord, Boolean isSelected) {
    this.contactRecord = contactRecord;
    this.isSelected = isSelected;
 }
 }
 
}