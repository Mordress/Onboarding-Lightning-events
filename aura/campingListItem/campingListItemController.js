({
    packItem: function (component, event, helper) {
        let newCampingItem = component.get("v.item");
        if (event.getSource().get("v.name") === "packed") {
            newCampingItem.Packed__c = true;
        }
        helper.updateItem(component, newCampingItem);
        component.set("v.item", newCampingItem);
    },

})