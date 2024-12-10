public class NurseRoomAllocationHelper {
	    public static void checkNurseRoomLimit(List<Rooms__c> newRooms) {
        
        set<string> setofname=new set<string>();
        for(rooms__c room : newRooms){
            setofname.add(room.Nurse__c);
        }
        list<rooms__c> listofroom=[select id, Nurse__c from rooms__c where Nurse__c in: setofname];
        map<string, rooms__c> existingmapacc=new map<string, rooms__c>();
        for(rooms__c rooms1: listofroom){
            existingmapacc.put(rooms1.Nurse__c, rooms1);
            
        }
        for(rooms__c rooms2: newRooms){
            if(existingmapacc.containsKey(rooms2.Nurse__c)){
                rooms2.addError('A nurse can be allocated to only one room.');
            }
        }
    } 

}