@isTest
private class LeadProcessorTest {
    private static final Integer COUNTER_OF_TESTED_LEADS = 200;

    @testSetup
    static void setup() {
        List<Lead> leadsToInsert = new List<Lead>();
        for (Integer i = 0; i < COUNTER_OF_TESTED_LEADS ; i++) {
            leadsToInsert.add(new Lead(lastName='Lead ' + i, company='VRP', status='Open - Not Contacted'));
        }
        insert leadsToInsert;
    }

    static testMethod void test() {
        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Id batchId = Database.executeBatch(leadProcessor);
        Test.stopTest();

        // after the testing stops, assert records were updated properly
        System.assertEquals(COUNTER_OF_TESTED_LEADS, [SELECT count() FROM lead WHERE LeadSource ='Dreamforce']);
    }
}