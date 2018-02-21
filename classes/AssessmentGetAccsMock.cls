public with sharing class AssessmentGetAccsMock {
    private static Integer countOfInsertedAccs = 20;

    public static void insertTestAccs() {
        List<Account> accs = new List<Account>();

        for (Integer i = 1; i <= countOfInsertedAccs; i++) {
            Account account = new Account();
            account.Name = 'Test acc ' + i;
            accs.add(account);
        }
        insert accs;
    }

}