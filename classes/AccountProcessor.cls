public with sharing class AccountProcessor {

    @future
    public static void countContacts(List<Id> accIds) {
        List<Account> accounts = [SELECT Id, Name, (SELECT Id, LastName FROM Contacts) FROM Account WHERE Id IN :accIds];
        for (Account acc : accounts) {
            acc.Number_of_Contacts__c = acc.Contacts.size();
        }
        update accounts;
    }

}