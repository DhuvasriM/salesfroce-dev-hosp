trigger NurseRoomAllocationTrigger on Rooms__c (before insert, before update) {
    if(trigger.isinsert && trigger.isbefore){
     NurseRoomAllocationHelper.checkNurseRoomLimit(Trigger.new);
    }
    if(trigger.isupdate && trigger.isbefore){
     NurseRoomAllocationHelper.checkNurseRoomLimit(Trigger.new);
    }
}