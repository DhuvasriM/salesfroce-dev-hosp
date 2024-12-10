public with sharing class PatientController {
    @AuraEnabled(cacheable=true)
    public static Patient__c getPatientDetails(String name) {
        name='%'+name+'%';
        //return [Select Id,Name,Doctor__r.Name,Address__c,Email__c,ID__c,Mobile__c,Status__c,Type__c from Patient__c where Name =:name Limit 1];

        return [SELECT First_Name__c, Age__c, Address__c, Contact_Number__c ,Room_No__r.Name,Stage__c, Assigned__r.Full_Name__c FROM Patient__c WHERE First_Name__c like : name LIMIT 10];
    }
    @AuraEnabled(cacheable=true)
    public static List<Patient__c> getPatientList(){
        return [SELECT Id, First_Name__c, Last_Name__c, Address__c, Contact_Number__c, Patient_Details__c, Age__c FROM Patient__c LIMIT 10];
    }
}