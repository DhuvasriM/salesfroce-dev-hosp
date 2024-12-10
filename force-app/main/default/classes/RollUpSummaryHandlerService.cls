public with sharing class RollUpSummaryHandlerService {
    public static void countActivePatients(Set<Id> docSetId){
        if(docSetId==null || docSetId.isEmpty())
        {
            return;
        }
        Map<Id, Doctor__c> activePatDocMap = new Map<Id, Doctor__c>();
        for (AggregateResult agg : [SELECT Assigned__c, COUNT(Id) FROM Patient__c WHERE Active__c=true AND Assigned__c IN :docSetId GROUP BY Assigned__c]) {
            Id docId = (Id)agg.get('Assigned__c');
            Integer totalPatients = (Integer)agg.get('expr0');
            activePatDocMap.put(docId, new Doctor__c(Id = docId, Active_Patients_Count__c = totalPatients));
        }

        for(Id docId : docSetId){
            if(!activePatDocMap.containsKey(docId)){
                activePatDocMap.put(docId, new Doctor__c(Id = docId, Active_Patients_Count__c = 0));
            }
        }
        update activePatDocMap.values();
    }
}