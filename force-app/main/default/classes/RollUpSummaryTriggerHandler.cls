public with sharing class RollUpSummaryTriggerHandler{
    public static void afterInsert(List<Patient__c> patList){
        Set<Id> docSetId=new Set<Id>();
            for(Patient__c pat:patList)
            {
                if(pat.Assigned__c!=null)
                {
                    docSetId.add(pat.Assigned__c);
                }
            }
        RollUpSummaryHandlerService.countActivePatients(docSetId);
    }
    public static void afterUpdate(List<Patient__c> patList, Map<Id,Patient__c> oldpatMap){
        Set<Id> docSetId=new Set<Id>();
            for(Patient__c pat:patList)
            {
                if(
                pat.Active__c!=oldpatMap.get(pat.Id).Active__c ||
                (pat.Assigned__c!=null && oldpatMap.get(pat.Id).Assigned__c==null))
                
                {
                    docSetId.add(pat.Assigned__c);
                }
                else if(pat.Assigned__c!=oldpatMap.get(pat.Id).Assigned__c)
                {
                    docSetId.add(pat.Assigned__c);
                    docSetId.add(oldpatMap.get(pat.Id).Assigned__c);
                }
            }
        RollUpSummaryHandlerService.countActivePatients(docSetId);
    }
    public static void afterDelete(List<Patient__c> patList){
        Set<Id> docSetId=new Set<Id>();
            for(Patient__c pat:patList)
            {
                if(pat.Assigned__c!=null)
                {
                    docSetId.add(pat.Assigned__c);
                }
            }
        RollUpSummaryHandlerService.countActivePatients(docSetId);
    }
    public static void afterUnDelete(List<Patient__c> patList){
        Set<Id> docSetId=new Set<Id>();
            for(Patient__c pat:patList)
            {
                if(pat.Assigned__c!=null)
                {
                    docSetId.add(pat.Assigned__c);
                }
            }
        RollUpSummaryHandlerService.countActivePatients(docSetId);
    }

}