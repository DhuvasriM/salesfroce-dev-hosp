global class ScheduledPatientEmail implements Schedulable {
    global void execute(SchedulableContext sc) {
        // Query patients who are discharged within the next 3 days and have not paid their bill
        Date threeDaysFromNow = Date.today().addDays(3);
        List<Patient__c> patientsToEmail = [SELECT Id, Name, Bill_Paid__c, Date_Discharged__c, Emergency_Contact_Email__c 
                                            FROM Patient__c 
                                            WHERE Bill_Paid__c = false 
                                            AND Date_Discharged__c = :threeDaysFromNow];

        // Call the sendEmail method
        PatientTriggerHandler.sendEmail(patientsToEmail);
    }
}