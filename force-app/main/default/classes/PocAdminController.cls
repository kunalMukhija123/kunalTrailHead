public class PocAdminController{

    public string imageDataURL {get;set;}
    public Contact objCon {get;set;}
    
    public PocAdminController(ApexPages.StandardController con){
        objCon = (Contact)con.getRecord();
    }
    
    public void saveCon(){
        insert objCon;
        System.debug('---obj Con ID-->>>.... ' +objCon);
        
        System.debug('---imageDataURL---->>>>... ' +imageDataURL);
        System.debug('---imageDataURL---->>>>... ' +imageDataURL.length());
        if(imageDataURL != null && imageDataURL.length() > 0){
        imageDataURL = imageDataURL.substring(22,imageDataURL.length());
        Attachment att = new Attachment();
        att.Body = EncodingUtil.base64Decode(imageDataURL);
        att.Name = 'DamageAreaImage.png';
        att.parentId = objCon.Id;  
            // '0030K00001NAd5N';
        if(att.Body != null){
            try{
                system.debug('+++++++++++'+att);
                upsert att;
            }catch(Exception ex){
                System.debug('=====Exception:'+ex.getLineNumber()+'   '+ex);
            }
        }
        }
      /*  PageReference acctPage = new ApexPages.StandardController(objCon).view();
        acctPage.setRedirect(true);
        return acctPage;   */      
}
}