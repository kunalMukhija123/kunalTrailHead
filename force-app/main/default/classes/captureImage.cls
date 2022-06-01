public class captureImage {

    public string imageDataURL {get;set;}
    
    public captureImage(){
        System.debug('---captureImage--->>>>.... ' +imageDataURL);
    }
    
    public void save(){
        System.debug('---imageDataURL---->>>>... ' +imageDataURL);
        if(imageDataURL != null){
        imageDataURL = imageDataURL.substring(22,imageDataURL.length());
        Attachment att = new Attachment();
        att.Body = EncodingUtil.base64Decode(imageDataURL);
        att.Name = 'DamageAreaImage.png';
        att.parentId = '0030K00001NAd5N';
        if(att.Body != null){
            try{
                system.debug('+++++++++++'+att);
                upsert att;
            }catch(Exception ex){
                System.debug('=====Exception:'+ex.getLineNumber()+'   '+ex);
            }
        }
        }
}
}