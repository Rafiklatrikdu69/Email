@RestResource(urlMapping='/c1/*')
global with sharing  class EmailManager {
    // /services/apexrest/c1
    // exemple : {
    //     "emails": ["a_young@dickenson.com","rose@edge.com"]
    //     }
    @HttpPost
    global static List<C1__c>  getEmail() {
        RestRequest     request    = RestContext.request;
        RestResponse    response   = RestContext.response;    

        response.addHeader('Content-Type','application/json');
        fromJSON jsonBody;
        try

        {

            jsonBody  = (fromJSON) JSON.deserialize(request.requestBody.toString(),fromJSON.class);

        }

        Catch(Exception ee)

        {

        }
            List<C1__c> c1 = new List<C1__c>();
         
             List<Contact> Contactemail = [
                 SELECT Id,
                 Email
                 FROM Contact
             ];
             for (Contact ct : Contactemail) {
              for (String email : jsonBody.emails) {
                 if(ct.Email == email){
                     C1__c c = [SELECT Id,
                     Name,
                     ContactId__c,
                     AccountId__c
                     FROM C1__c
                    WHERE ContactId__c = :ct.Id];
                     c1.add(c);
                 }
              }
         }
      
         return c1;
    }

    public class fromJSON

    {

        public List<String> emails;    //Value1


    }
}