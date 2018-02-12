({
    packItem: function (component, event, helper) {
        /*let pack = component.get("v.item");
        pack.Packed__c = true;
        component.set("v.item", pack);

        let button = event.getSource();
        button.set("v.disabled", true);*/
        let newCampingItem = component.get("v.item");
        newCampingItem.Packed__c = true;
        helper.updateItem(component, newCampingItem);
        component.set("v.item", newCampingItem);
    },

})