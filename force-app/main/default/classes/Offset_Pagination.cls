public class Offset_Pagination{

    public integer listSize{get;set;}
    private integer limitSize = 5 ;
    public integer counter{get;set;}
    private integer totalSize = 0 ;
    
    public Integer pageNumber{set;get;}
    public Boolean firstOff{set;get;}   
    public Boolean lastOff{set;get;}   

   public Offset_Pagination(){
       counter = 0;
        totalSize = [select count() from contact];
        firstOff = false;
        pageNumber = 1;
        system.debug('-----------Total Size1-------------'+totalSize);     
        if(listSize > limitSize){
        lastOff = true;
        } 
        else{
        lastOff = false; 
        }   
    }
    
    public List<contact> getRecords(){
        try{
        List<contact> ListOfcontacts = new List<contact>();
        ListOfcontacts = [SELECT FirstName , LastName FROM contact order by FirstName limit :LimitSize offset :Counter];
        ListSize = ListOfContacts.Size();
        system.debug('----------ListSIze------------'+ListSize);
        system.debug('----------ListOFContacts------------'+ListOfContacts);
        return ListOfContacts ;
        }
        catch (QueryException e) {
         ApexPages.addMessages(e);   
         return null;
      }
          
    }
    
  /* public Integer getPageNumber(){
        return counter/limitSize + 1;
   }
      public Integer getTotal_size(){
        return totalSize;
   }  */
   
    
  /*  public Integer getTotalPages(){
        if (math.mod(totalSize, limitSize) > 0){
            return totalSize/limitSize + 1;
        }else{
            return (totalSize/limitSize);
        }
    }   */

    public void First(){
        counter = 0;
        firstOff = false;
        lastOff = true;
        pageNumber = 1 ;
        system.debug('---------Page Number with first------' +pageNumber);
        system.debug('----------Counter Value First-----'+counter);
    }
    
    public void Previous(){
        //counter = counter - limitSize ;
        if(counter-limitSize <= 0 ){
            counter = 0;
            firstOff = false;
        }else{
        counter = counter - limitSize ;
         lastOff = true;
        pageNumber--;
        system.debug('--------page Number with Previous--------' +pageNumber);
        }
        
        system.debug('----------Counter Value previous-----'+counter);
    }
    
    public void Next(){
        counter = counter + limitSize ;
        if(counter + limitSize >= ListSize ) lastOff = true;
        firstOff = true;
        pageNumber++;
        system.debug('-----Page Number with Next----------'+pageNumber++);
        system.debug('----------Counter Value Next-----'+counter);
    }
    
    public void Last(){
        //counter  = totalSize - math.mod(totalSize ,limitSize );
        //system.debug('----------Counter Value Last-----'+counter);
        if(Math.Mod(totalSize,limitSize) == 0){
            counter = listSize - limitSize;
            pageNumber = listSize/limitSize;
        }
        else{
            counter = (listSize/limitsize)*limitSize;
            pageNumber = (listSize/limitSize)+1;
        }
        
        lastOff = false;
        firstOff = true;
    }        
    
 /*   public boolean getprev(){
        system.debug(counter);
        if(counter == 0){
            return true;
        }else{
            return false;
        }
    }  
    
    public boolean getNext(){
    system.debug('-----------Value of counter------------'+counter);
        if((counter + limitSize) >= totalSize){
            return true;
        }else{
        return false;
        }
    } */
}