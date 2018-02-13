public with sharing class CampingListController {

    /* Types of CRUD operations */
    private static final String READ_OPERATION = 'READ';
    private static final String DELETE_OPERATION = 'DELETE';
    private static final String UPDATE_OPERATION = 'UPDATE';

    /*Return result of checking permission for this operation */
    private static Boolean checkOperationType(Schema.SObjectField fld, String operation) {
        if (operation.equals(READ_OPERATION)) {
            return fld.getDescribe().isAccessible();
        } else if (operation.equals(UPDATE_OPERATION)) {
            return fld.getDescribe().isUpdateable();
        } else if (operation.equals(DELETE_OPERATION)) {
            return !fld.getDescribe().isRestrictedDelete();
        }
        return null;
    }

    /* Checks fields of Camping_Item__c for user permissions */
    private static Boolean checkPermission(String operation) {
        String[] campingAccessFields = new String[] {
        'Name', 'Packed__c', 'Price__c', 'Quantity__c'
        };
        Map<String, Schema.SObjectField> m = Schema.SObjectType.Camping_Item__c.fields.getMap();

        for (String fieldToCheck : campingAccessFields) {
            if (!checkOperationType(m.get(fieldToCheck), operation)) {
                System.NoAccessException exc = new System.NoAccessException();
                exc.setMessage('Field with throuble: ' + fieldToCheck + '. Operation with throuble: ' + operation);
                throw exc;
                return false;
            }
        }
        return true;
    }

    private static Boolean checkPermissionRead() {
         return checkPermission(READ_OPERATION);
    }
    private static Boolean checkPermissionUpdate() {
        return checkPermission(UPDATE_OPERATION);
    }
    private static Boolean checkPermissionDelete() {
         return checkPermission(DELETE_OPERATION);
    }

    private static List<Camping_Item__c> get_UNSAFE_Items() {
        return [SELECT Id, Name, Packed__c, Price__c, Quantity__c FROM Camping_Item__c ORDER BY Id];
    }
    private static Boolean purge_UNSAFE_Items() {
        List<Camping_Item__c> listToDel = [SELECT Id, Name, Packed__c, Price__c, Quantity__c FROM Camping_Item__c];
        delete listToDel;
        return true;
    }

    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        return checkPermissionRead() ? CampingListController.get_UNSAFE_Items() : null;
    }

    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c campingItem) {
        if (checkPermissionUpdate()) {
            upsert campingItem;
            return campingItem;
        }
        return null;
    }

    @AuraEnabled
    public static Boolean purgeItems() {
        if (!checkPermissionDelete()) {
            return false;
        }
        return purge_UNSAFE_Items();
    }
}