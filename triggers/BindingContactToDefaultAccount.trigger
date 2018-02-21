trigger BindingContactToDefaultAccount on Contact (before insert) {
    private static String DEFAULT_ACCOUNT_NAME = 'Default';
    private Account defaultAccount;

    try {
        defaultAccount = [SELECT Id FROM Account WHERE Name=:DEFAULT_ACCOUNT_NAME];
        for(Contact newContact : Trigger.New) {
            newContact.AccountId = defaultAccount.Id;
        }
    } catch (QueryException e) {
        System.debug(LoggingLevel.ERROR, 'Failed to assign new contact to default account,' +
                ' because Account with \'Default\' name is not exists!' +
                ' Check BindingContactToDefaultAccount trigger.');
    }
}