({
	myAction : function(component, event, helper) {
		var accounts = component.get("v.accounts");
        var row = '<tbody>';
        accounts.forEach(function(account) {
            row += '<tr class="slds-hint-parent">';
            row += '<td data-label="activity">';
            row += '<span class="slds-truncate">'+account.get("Name")+'</span></td>';
            row += '<td data-label="confidence">';
            row += '<span class="slds-truncate">'+account.get("Phone")+'</span></td>';
            row += '<td data-label="confidence">';
            row += '<span class="slds-truncate">'+account.get("Active__c")+'</span></td>';
            row += '</tr>';
        });
        row += '</tbody>';
        jQuery('#tb').append(row);
	}
})