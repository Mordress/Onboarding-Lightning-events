public with sharing class LeadProcessor implements Database.Batchable<sObject> {
    public static final String NEW_LEAD_SOURCE = 'Dreamforce';

    public Database.QueryLocator start(Database.BatchableContext param1) {
        return Database.getQueryLocator('SELECT Id, Name, Company, LeadSource FROM Lead');
    }

    public void execute(Database.BatchableContext param1, List<Lead> scope) {
        List<Lead> leads = new List<Lead>();
        for (Lead ld : scope) {
            ld.LeadSource = NEW_LEAD_SOURCE;
            leads.add(ld);
        }
        update leads;
    }

    public void finish(Database.BatchableContext param1) {
    }

}