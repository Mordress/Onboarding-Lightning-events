public with sharing class CampingListController {

    private static void checkPermissionForRead() {

    }

    @AuraEnabled
    public static List<Camping_Item__c> get_UNSAFE_Items() {
        return [SELECT Id, Name, Packed__c, Price__c, Quantity__c FROM Camping_Item__c ORDER BY Name];
    }

    /* Checking permissions for getting camping items */
    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        String[] campingAccessFields = new String[] {
                'Id', 'Name', 'Packed__c', 'Price__c', 'Quantity__c'
        };
        Map<String, Schema.SObjectField> m = Schema.SObjectType.Camping_Item__c.fields.getMap();
        for (String fieldToCheck : campingAccessFields) {
            if (!m.get(fieldToCheck).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
                return null;
            }
        }
        return CampingListController.get_UNSAFE_Items();
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