public class CapturePhoto {
    public ContentVersion cont {get;set;}
    public CapturePhoto(Apexpages.StandardController controller){
        cont = new ContentVersion();
    }
    public pageReference savePhoto(){
        try{
            cont.PathOnClient = cont.title;
            cont.Origin = 'H';
            insert cont;
            return new PageReference('/'+cont.id);
        }catch(Exception ex){
            System.debug('@@'+ ex.getMessage());
        } 
        return Apexpages.currentpage();          
    }
}