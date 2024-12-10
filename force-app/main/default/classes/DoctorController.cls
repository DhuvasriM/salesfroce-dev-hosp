public with sharing class DoctorController {
    @AuraEnabled(cacheable=true)
    public static List<Doctor__c> getDoctors() {
        return [SELECT Id,Full_Name__c, Specialization__c FROM Doctor__c];
    }
}