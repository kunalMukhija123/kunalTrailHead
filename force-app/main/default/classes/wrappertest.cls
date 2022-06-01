public class wrappertest {
    
    public list<productwrapper> recordlist { get; set;}
    public list<selectoption> status;
    public string selectedstatus { get; set;}
    
    public wrappertest(){
        list<product2> pro = [select id, name, isactive from product2];
        if(pro.size()!=0){
            recordlist = new list<productwrapper>();
        }
        for(product2 p:pro){
            recordlist.add(new productwrapper(p));
        }
        
        selectedstatus = 'active';
        
    }
    
    public list<selectoption> getStatus(){
        status = new list<selectoption>();
        status.add(new selectoption('active','Active'));
        status.add(new selectoption('inactive','In-Active'));
        return status;
    }
    
    public void changestatus(){
        list<product2> prolist = new list<product2>();
        for(productwrapper pw: recordlist){
            if(pw.selected){
                if(selectedstatus == 'active'){
                    pw.record.isactive = true;
                }else if(selectedstatus == 'inactive'){
                    pw.record.isactive = false;
                }
                pw.selected=false;
                prolist.add(pw.record);
            }
        }
        update prolist;
    }
    
    public class productwrapper{
        public boolean selected { get; set;}
        public product2 record {get;set;}
      
        public productwrapper(product2 record){
            this.record = record;
            selected = false;  
        }
    }
}