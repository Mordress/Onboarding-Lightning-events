({
    updateItem: function (component, newCampingItem) {
        let createEvent = component.getEvent("changedItem");
        createEvent.setParams({"item": newCampingItem});
        createEvent.fire();
    }
})