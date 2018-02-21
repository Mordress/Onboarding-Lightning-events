@isTest
public with sharing class AddPrimaryContactTest {

    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        // add 100 accounts
        for (Integer i = 0; i < 100; i++) {
            if (i < 50) {
                accounts.add(new Account(
                        name='Test Account'+i,
                        BillingState='NY'
                ));

            } else {
                accounts.add(new Account(
                        name='Test Account'+i,
                        BillingState='CA'
                ));
            }

        }
        upsert accounts;
    }

    static testmethod void testQueueable() {
        Contact conToIns = new Contact(LastName='XXX');
        AddPrimaryContact contactAdder = new AddPrimaryContact(conToIns, 'CA');
        AddPrimaryContact contactAdder2 = new AddPrimaryContact(conToIns, 'NY');
        Test.startTest();
        System.enqueueJob(contactAdder);
        System.enqueueJob(contactAdder2);
        Test.stopTest();

        System.assertEquals(100, [SELECT count() FROM Contact WHERE LastName = 'XXX']);

    }

}