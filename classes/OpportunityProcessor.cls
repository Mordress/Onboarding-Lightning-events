global with sharing class OpportunityProcessor implements Database.Batchable<sObject>, Database.Stateful {
    global List<Opportunity> todayClosedOpps = new List<Opportunity>();


    public Database.QueryLocator start(Database.BatchableContext param1) {
        return Database.getQueryLocator('SELECT Id, Name, AccountId, CloseDate FROM Opportunity');
    }

    public void execute(Database.BatchableContext param1, List<Opportunity> scope) {


        for (Opportunity opportunity : scope) {
            //TODO CHECK CLOSE DATE
            todayClosedOpps.add(opportunity);
        }
    }

    public void finish(Database.BatchableContext param1) {
        //TODO Create email and pass global list into it, send it
    }
}