({
    doInit: function(component, event, helper) {
        // Create the action
        let action = component.get("c.getItems");

        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });

        // Send action off to be executed
        $A.enqueueAction(action);
    },


    purge: function (component, event, helper) {
        let action = component.get("c.purgeItems");
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log("ALL ITEMS DELETED!");
                component.set("v.items", []);
            }
        });
        $A.enqueueAction(action);
    },
    handleAddItem: function (component, event, helper) {
        let newCampingItem = event.getParam("item");
        console.log(newCampingItem);
        helper.createCampingItem(component, newCampingItem);
    }
})