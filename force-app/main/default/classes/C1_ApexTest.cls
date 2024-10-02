@IsTest
public with sharing class C1_ApexTest {
    @IsTest
    public static void testInsertC1Excel() {
        C1__c c1 = new C1__c(
            Name = 'C1 de test',
            AccountId__c = 'a2HWZ00000008Yf2AI',
            ContactId__c = 'a2FWU00000008Yf2AI'
        );
        Test.startTest();
        Database.SaveResult result = Database.insert(c1, false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assertEquals('C1 de test', c1.Name);
    }
    @IsTest
    public static void testInsertC1ExcelMissingField() {
        C1__c c1 = new C1__c(
            Name = 'C1 de test'
            // AccountId__c et ContactId__c sont manquants
        );
        Test.startTest();
        Database.SaveResult result = Database.insert(c1, false);
        Test.stopTest();
    
        System.assert(!result.isSuccess());
        System.assertEquals(2, result.getErrors().size());
    }
    @IsTest
    public static void testInsertC1ExcelInvalidId() {
        C1__c c1 = new C1__c(
            Name = 'C1 de test',
            AccountId__c = 'InvalidId',
            ContactId__c = 'InvalidId'
        );
        Test.startTest();
        Database.SaveResult result = Database.insert(c1, false);
        Test.stopTest();
    
        System.assert(!result.isSuccess());
    }
}