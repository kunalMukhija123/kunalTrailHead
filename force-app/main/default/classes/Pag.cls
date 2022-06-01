public class Pag{

public List<PriceBookWrapper> ConWrapList{ get; set; }
public List<PricebookEntry> PriceBookEntry{get;set;}
// public List<PricebookEntry> Pbe{get;set;}
 public List<opportunityLineItem> OppLineItem{get;set;}
 public OpportunityLineItem opp{get;set;}
 public string oppID {get;set;} 
 public boolean Show_Hide{get;set;}
 
public opportunity oppObj {get ; set ; }
 public Integer temporary{get;set;}  

   private integer counter=0;  
   private integer list_size=5
   ; 
   public integer total_size; 
   
   public Pag(){
   ConWrapList = new List<PriceBookWrapper>();
 //opp = new OpportunityLineItem();
 Show_Hide = false;
   oppID = ApexPages.currentPage().getParameters().get('id');
   OppLineItem = new List<opportunityLineItem>();
    
   oppObj = [SELECT PriceBook2Id , Name FROM Opportunity WHERE id =: oppID];
   // total_size = [select count() from PricebookEntry WHERE PriceBook2Id =: oppObj.PriceBook2Id];
   String s ='select Count () from PricebookEntry WHERE PriceBook2Id =: oppObj.PriceBook2Id';
        if(alpha != 'All' && alpha != null && alpha != '')
        {
            String temp = alpha+'%';
            s += ' where name like : temp';          
        }
              
        temporary = database.countQuery(s);        
        total_size = temporary;
       // return total_size ;
   
   // PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];

   List<PricebookEntry> priceBook = [SELECT Product2.Name , ProductCode,unitPrice FROM PricebookEntry WHERE PriceBook2Id =: oppObj.PriceBook2Id  order by ProductCode limit :list_size offset :counter];
   system.debug('-------------price bbok  List Data---------- '+ priceBook );
   if(priceBook != null && priceBook.size() > 0){
           for(priceBookEntry pb : priceBook){
           ConWrapList.add(new PriceBookWrapper(pb));
           }
       }
       system.debug('-------------wrapper List Data---------- '+ ConWrapList );
   }
   
   public class PriceBookWrapper{
    
        public Boolean isSelected{get ; set ;}
        public PriceBookEntry conObj{get ; set ;}
        
        public PriceBookWrapper(priceBookEntry conObj){
            this.conObj =conObj;
            isSelected = false;
        }
    }
    
   public void SelectRecord(){
   // Pbe = new List<PriceBookEntry>();
    
        for(PriceBookWrapper c : conWrapList){
            if(c.isSelected==true){
            OppLineItem.add(new OpportunityLineItem(opportunityId = oppID , priceBookEntry = c.conObj , unitPrice = c.conObj.unitPrice )) ;
            c.isSelected=false;
            
            }
            Show_Hide = true;
        }
       
 /*       PageReference pageRef = new PageReference('/apex/Selected_OppProducts');    
      //  pageRef.setRedirect(true);
         return pageRef;  */
   }  
   
   
   public pageReference save(){
         for(integer i = 0 ; i<OppLineItem.size();i++)
             OppLineItem[i].priceBookEntryId = OppLineItem[i].priceBookEntry.Id;
             insert OppLineItem;
             return new PageReference('/'+oppID);  
       }   
       
       public pageReference Cancel1(){
         PageReference pageRef = new PageReference('/'+oppID);    
         pageRef.setRedirect(true);
         return pageRef;  
       }    
       
       public void Cancel(){
          OppLineItem.clear();
          Show_Hide = false;
       }
       
      Public void Records(){
           List<priceBookEntry> RecordTOShow = new List<priceBookEntry>();
           ConWrapList = new List<PriceBookWrapper>();
           
           system.debug('-----obj data------'+oppobj);
           RecordToShow = [SELECT Product2.Name , ProductCode,unitPrice FROM PricebookEntry WHERE PriceBook2Id =: oppObj.PriceBook2Id  order by ProductCode limit :list_size offset :counter];
             system.debug('------Record to show List Data---------------'+RecordToShow);
           
           if(RecordToShow != Null && RecordToShow.size() > 0){
               for(PriceBookEntry p : RecordToShow){
                   conWrapList.add(new PriceBookWrapper(p));
               } 
               
           }
       } 
 
    public Integer getTotal_size() {
      return total_size;
   }
   
   public Integer getPageNumber() {
      return counter/list_size + 1;
   }
   
   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }

   public void Beginning() { 
      counter = 0;
      Records();
   }

   public void Previous() { 
      counter = counter - list_size;
      Records();
   }

   public void Next() { 
      counter = counter + list_size;
      Records();
   }

   public void End() { 
      counter = total_size - math.mod(total_size, list_size);
      Records();
      
   }

   public Boolean getDisablePrevious() { 
      if (counter>0){
           return false; 
      }else {
      return true;
      }
   }

   public Boolean getDisableNext() { 
      if (counter + list_size < total_size){
      return false; 
      }else{
       return true;
       } 
   }
 
  Public string alpha{get;set;}
  
    public void SortList() {
       string x = alpha + '%';
        
       List<PricebookEntry> p = new List<PricebookEntry>();
       conWrapList =  new List<PriceBookWrapper>();
       if(alpha == 'All'){
           p  = [select  Product2.Name , ProductCode , unitPrice from PriceBookEntry where PriceBook2Id =: oppObj.PriceBook2Id order by Product2.Name limit :list_size offset :counter];
       }else{
           p  = [select  Product2.Name , ProductCode , unitPrice from PriceBookEntry where PriceBook2Id =: oppObj.PriceBook2Id and Product2.Name LIKE : x limit :list_size offset :counter];
           
           
       }
       
       system.debug('-----List P of Data ---------'+p);
           if(p.size()>0){
               for(PriceBookEntry pe : p){
                   conWrapList.add(new PriceBookWrapper(pe));
               }
           }
           else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Records does not exists !!'));
           }
       } 
      
       
        

}