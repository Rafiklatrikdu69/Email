public class BatchVerifEmailBounced implements Database.Batchable<sObject> {
 /**
     * 
     * @param BC 
     * @return  `Database.QueryLocator`
     */
    public Database.QueryLocator start (Database.BatchableContext BC){
        String soql = 'SELECT Id,ContactId__c FROM C1__c';
        return Database.getQueryLocator(soql);
    }
    /**
     * 
     * @param BC 
     * @param scope 
     */
public void execute(Database.BatchableContext BC, List<C1__c> scope) {
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
    OrgWideEmailAddress orgWideEmail = [
        SELECT Id, displayname
        FROM OrgWideEmailAddress
        WHERE displayname = 'OrgEmailAdress'
    ];

    EmailTemplate emailTemplate = [
        SELECT Id, HtmlValue, Subject, Body, Developername
        FROM EmailTemplate
        WHERE Developername = 'EmailTemplateTest'
    ];
    
    String subject = emailTemplate.Subject;
    String bodyMain = emailTemplate.HtmlValue;

    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
    message.setOrgWideEmailAddressId(orgWideEmail.Id);
    message.setToAddresses(new List<String>{'rafik.bouchenna050@gmail.com'});
    String contactBounced = '';
    
    for (C1__c contact : scope) {
        String t = contact.ContactId__c + '';
        List<Contact> contacts = [
            SELECT Id, EmailBouncedReason, Name
            FROM Contact
            WHERE Id = :t AND EmailBouncedDate != null
        ];
        for (Contact contactEmail : contacts) {
            String link = 'https://playful-fox-otispm-dev-ed.trailblaze.lightning.force.com/lightning/r/Contact/' + contactEmail.Id + '/view';
            contactBounced += 'Un email est hardbounced <a href=' + link + '>' + contactEmail.Name + '</a>';
            System.debug(contactEmail);
        }
    }
    
    message.setHtmlBody(contactBounced);
    message.setSubject(subject);
    message.setSaveAsActivity(false); // tracer l'email
    emails.add(message);

    Messaging.sendEmail(emails);
}

    
    /**
     * 
     * @param BC 
     */  
    public void finish(Database.BatchableContext BC){
      
    }  
}