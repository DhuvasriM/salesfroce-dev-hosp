trigger PatientTrigger on Patient__c (before insert, after insert, after update) {
    
    if(trigger.isinsert){
        if(trigger.isafter){
            PatientTriggerHandler.sendEmail(trigger.new);
            
        }
    }
    if(trigger.isupdate){
        if(trigger.isafter){
            PatientTriggerHandler.updateRoomBeds(trigger.oldmap, trigger.newmap);
        }
    }

}