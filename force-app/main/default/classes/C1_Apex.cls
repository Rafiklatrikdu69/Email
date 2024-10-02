public with sharing class C1_Apex {
 
    @AuraEnabled
    public static C1__c insertC1Excel(String Name,String contact,String acc){
            
        C1__c newC1 = new C1__c();
        newC1.Name = Name;
        newC1.ContactId__c = contact;
        newC1.AccountId__c = acc;
        System.debug(newC1);
        try{
            insert newC1;
        }catch(Exception e){

            System.debug(e);
        }
        return newC1;
    }
}