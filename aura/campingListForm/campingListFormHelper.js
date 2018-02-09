({
    createItem: function (component, newCampingItem) {
        let createEvent = component.getEvent("addItem");
        createEvent.setParams({"item": newCampingItem});
        createEvent.fire();
    }
})