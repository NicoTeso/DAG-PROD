trigger DuplicateRecordItemTrigger on DuplicateRecordItem (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    TriggerFactory.createHandler(DuplicateRecordItem.sObjectType);
}