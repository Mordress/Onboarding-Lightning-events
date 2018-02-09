({
    clickCreateItem: function (component, event, helper) {
        //remove page reload
        //event.preventDefault();
        let validCampingItem = component.find('campingform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validCampingItem){
            let newCampingItem = component.get("v.newItem");
            console.log(newCampingItem);
            helper.createItem(component, newCampingItem);
            component.set("v.newItem", { 'sobjectType': 'Camping_Item__c',
                'Name':'', 'Quantity__c': 0, 'Price__c': 0, 'Packed__c': false });
        }
    },

})