({    
    createContact : function(component , event , helper) {
        // alert('in');
        var lastname = component.set("v.newContact.LastName","Mukhija") ;
        var firstname = component.set("v.newContact.FirstName","Kunal") ;
        var newCon = component.get("v.newContact");
        var acntId = component.get("v.recordId")
        var action = component.get("c.saveContact");
        action.setParams({ 
            "con": newCon,
            "con1": acntId
        });
        action.setCallback(this,function(response){
            var state =  response.getState();
            //  alert(state);
            if(state == 'SUCCESS'){
                var getResponse = response.getReturnValue();
                // alert(getResponse);
                console.log('Inserted Records', getResponse) ; 
                component.set("v.contacts",getResponse);
            } 
        }) ;
        $A.enqueueAction(action);
    }
    
})