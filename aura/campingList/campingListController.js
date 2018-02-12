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

    handlePrimaryButtonClick: function(component, event, helper) {
        console.log(event);
        let action = component.get("c.purgeItems");
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                console.warn("ALL ITEMS DELETED!");
                component.set("v.items", []);
            }
        });
        $A.enqueueAction(action);
        component.set('v.toggleModal', false);
    },

    purge: function (component, event, helper) {
        //let purgeConfirmationWindow = component.find("purgeconfirm");
        component.set('v.toggleModal', true);
    },

    handleAddItem: function (component, event, helper) {
        helper.saveItem(component, event, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let campingItems = component.get("v.items");
                campingItems.push(response.getReturnValue());
                component.set("v.items", campingItems);
            }
        });
    },
    handleChangeItem: function (component, event, helper) {
        helper.saveItem(component, event, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log("successfully updated!");
            }
        });
    },
})