public class PatientTriggerHandler {
    public static void dateofadmit(list<Patient__c> listofpatient){
        for(Patient__c pat:listofpatient){
            pat.Date_Admitted__c = system.Today();
        }
    }
    public static void sendEmail(List<Patient__c> listOfPatients) {
        
        Date tomorrow = Date.today().addDays(1);

        List<Patient__c> patientsToEmail = new List<Patient__c>();

        for (Patient__c patient : listOfPatients) {
            
            if (!patient.Bill_Paid__c && patient.Date_Discharged__c!= null && 
                patient.Date_Discharged__c == tomorrow) {
                patientsToEmail.add(patient);
            }
        }

        if (!patientsToEmail.isEmpty()) {
            
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

            for (Patient__c patient : patientsToEmail) {
                if (patient.Emergency_Contact_Email__c != null) {
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new String[] { patient.Emergency_Contact_Email__c});
                    email.setSubject('Reminder to Pay Your Bill');
                    email.setPlainTextBody('Dear ' + patient.Name + ',\n\n' +
                        'This is a reminder to pay your bill. Your discharge date is tomorrow (' + patient.Date_Discharged__c.format() + 
                        ') and our records show that the bill has not been paid yet.\n\n' +
                        'Please make the payment at your earliest convenience.\n\n' +
                        'Thank you.');

                    
                    emails.add(email);
                } else {
                    System.debug('Email is null for Patient: ' + patient.Id);
                }
            }

            
            if (!emails.isEmpty()) {
                Messaging.sendEmail(emails);
            }
        }
    }

	public static void updateRoomBeds(Map<Id, Patient__c> oldPatients, Map<Id, Patient__c> newPatients) {
        
        Set<Id> roomIds = new Set<Id>();

        
        for (Patient__c patient : newPatients.values()) {
            if (patient.Room_No__c != null) {
                roomIds.add(patient.Room_No__c);
            }
        }

        
        Map<Id, Rooms__c> roomsToUpdate = new Map<Id, Rooms__c>();

        
        for (Rooms__c room : [SELECT Id, Total_no_of_beds__c, No_of_Beds_Available__c FROM Rooms__c WHERE Id IN :roomIds]) {
            roomsToUpdate.put(room.Id, room);
        }

        
        for (Patient__c pid : newPatients.values()) {
            Patient__c newPatient = newPatients.get(pid.id);
            Patient__c oldPatient = oldPatients.get(pid.id);

            if (newPatient.Patient_Status__c != oldPatient.Patient_Status__c) {
                if (newPatient.Patient_Status__c == 'Discharged') {
                    if (roomsToUpdate.containsKey(newPatient.Room_No__c)) {
                        Rooms__c room = roomsToUpdate.get(newPatient.Room_No__c);
                        room.No_of_Beds_Available__c += 1;
                        if (room.No_of_Beds_Available__c > room.Total_no_of_beds__c) {
                            room.No_of_Beds_Available__c = room.Total_no_of_beds__c;
                        }
                    }
                } else if (newPatient.Patient_Status__c != 'Discharged' && newPatient.Room_No__c != null) {
                    if (roomsToUpdate.containsKey(newPatient.Room_No__c)) {
                        Rooms__c room = roomsToUpdate.get(newPatient.Room_No__c);
                        room.No_of_Beds_Available__c -= 1;
                         if (room.No_of_Beds_Available__c < 0) {
                            room.No_of_Beds_Available__c = 0;
                        }
                    }
                    
                }
            }
        }

        
        if (!roomsToUpdate.isEmpty()) {
            update roomsToUpdate.values();
        }
    }

}