public with sharing class AddPrimaryContact  implements Queueable{
    private Contact contact;
    private String state;

    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }


    public void execute(QueueableContext context) {
        List<Contact> cons = new List<Contact>();
        List<Account> accs = [SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts)
                             FROM Account WHERE BillingState = :state LIMIT 200];

        for (Account account : accs) {
            Contact c = this.contact.clone();
            c.AccountId = account.Id;
            cons.add(c);
            /*account.Contacts.add(this.contact.clone());*/
        }
        upsert cons;
    }
}