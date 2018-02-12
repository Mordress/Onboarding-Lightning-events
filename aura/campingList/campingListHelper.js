({
    //utility method for change and add items handling
    saveItem: function(component, event, callback) {
        let newCampingItem = event.getParam("item");
        let action = component.get("c.saveItem");
        action.setParams({"campingItem": newCampingItem});

        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },
})