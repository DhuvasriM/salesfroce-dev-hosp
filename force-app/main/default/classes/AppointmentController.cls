public with sharing class AppointmentController {
    @AuraEnabled(cacheable=true)
    public static List<Appointments__c> getAppointmentsByDoctor(Id doctorId) {
        return [SELECT Id, Patient__r.Full_Name__c, Appointment_Type__c
                FROM Appointments__c 
                WHERE Doctor__c = :doctorId];
    }
}