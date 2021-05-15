public with sharing class CarController {
    @AuraEnabled(Cacheable=true)
    public static List<car__c> getCars() {
        return [SELECT Id, Name, MSRP__c, Description__c, Category__c, Control__c, Make__c, Picture_URL__c FROM Car__c];
    }
}
