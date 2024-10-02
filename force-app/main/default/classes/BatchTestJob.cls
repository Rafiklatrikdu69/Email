@Istest
public with sharing class BatchTestJob {
    @IsTest
    public static void testBatchJob()
    {
        C1__c c1 = new C1__c(
            name = 'Email'
        );
        insert c1;
    }
}