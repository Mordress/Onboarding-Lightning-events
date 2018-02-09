({
    createCampingItem: function (component, newCampingItem) {
        let action = component.get("c.saveItem");
        action.setParams({"campingItem": newCampingItem});
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let campingItems = component.get("v.items");
                campingItems.push(response.getReturnValue());
                component.set("v.items", campingItems);
            }
        });
        $A.enqueueAction(action);
    }
})