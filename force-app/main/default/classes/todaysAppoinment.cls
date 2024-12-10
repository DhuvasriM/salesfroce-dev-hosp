public with sharing class todaysAppoinment {
    @AuraEnabled
    public static list<Appointments__c> tdysAppoint() {
        Date today = Date.today();

        return [select Name,Patient__r.First_Name__c,Patient__r.Last_Name__c,Status__c,Date_and_Time__c from Appointments__c where Date_and_Time__c =:today];

    }
}