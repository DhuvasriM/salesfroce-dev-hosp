trigger RollUpSummaryTrigger on Patient__c (after insert, after update, after delete, after undelete) {
    switch on Trigger.operationType {
        when  AFTER_INSERT{
            RollUpSummaryTriggerHandler.afterInsert(Trigger.new);
        }
        when AFTER_UPDATE{
            
            RollUpSummaryTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
        when AFTER_DELETE{
            
            RollUpSummaryTriggerHandler.afterDelete(Trigger.old);
        }
        when AFTER_UNDELETE{
            
            RollUpSummaryTriggerHandler.afterUnDelete(Trigger.new);
        }
    }
}