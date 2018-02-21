@isTest(SeeAllData=true)
public with sharing class AccountProcessorTest {

    private static final Map<Id, Integer> ACCS_CNTS_MOCK = new Map<Id, Integer>{'0017F00000TUdSyQAL'=> 4,
                                                                                '0017F00000USRB9QAP'=> 0,
                                                                                '0017F00000TUdSuQAL'=> 1,
                                                                                '0017F00000USRZbQAP'=> 0,
                                                                                '0017F00000USRZcQAP'=> 0};

    @isTest
    private static void testCountingContacts() {
        List<Id> accsIds = new List<Id>(ACCS_CNTS_MOCK.keySet());

        Test.startTest();
        AccountProcessor.countContacts(accsIds);
        Test.stopTest();

        System.debug('--------------------');

        for (Id iterId : ACCS_CNTS_MOCK.keySet()) {
            System.assertEquals(ACCS_CNTS_MOCK.get(iterId),
                    [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :iterId].Number_of_Contacts__c);
        }
    }


}