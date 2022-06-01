({
    doInit : function(component, event, helper) {
        //  alert(component.get("v.recordId"));
    },
    
    createContact : function(component, event, helper) {
        // alert(component.find('con_num').get("v.value")) ;
        helper.createContact(component);
        
    }
    
})