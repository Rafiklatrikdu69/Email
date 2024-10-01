public class EmailBounced {
    public static void printEmailBounced(){
        List<Contact> contacts = [SELECT Email,Name FROM Contact WHERE EmailBouncedDate != null];
        System.debug(contacts);
    }
}