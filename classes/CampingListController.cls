public with sharing class CampingListController {

    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        return [SELECT Id, Name, Packed__c, Price__c, Quantity__c FROM Camping_Item__c ORDER BY Name];
    }

    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c campingItem) {
        upsert campingItem;
        return campingItem;
    }

    @AuraEnabled
    public static Boolean purgeItems() {
        List<Camping_Item__c> listToDel =[SELECT Id, Name, Packed__c, Price__c, Quantity__c FROM Camping_Item__c];
        try {
            delete listToDel;
            System.debug('DELETED' + listToDel);
        } catch (Exception e) {
            System.debug(e);
            return false;
        }
        return true;
    }
}