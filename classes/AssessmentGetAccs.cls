public with sharing class AssessmentGetAccs {
    private static final Integer COUNT_OF_ACCOUNTS = 200;
    private static List<Account> accounts;

    public static List<Account> getLastAccounts() {
        try {
            accounts = [SELECT Id, Name, CreatedDate FROM Account ORDER BY CreatedDate DESC LIMIT :COUNT_OF_ACCOUNTS];
        } catch (QueryException e) {
            System.debug(e.getMessage() +'\n'+ e.getCause());
            accounts = new List<Account>();
        }
        return accounts;
    }
}