public with sharing class CarController {

    // Wrapper class
    public class Filters {
        @AuraEnabled
        public  String searchKey {get;set;}
        @AuraEnabled
        public  Decimal maxPrice {get;set;}
        @AuraEnabled
        public  String[] categories {get;set;}
        @AuraEnabled
        public  String[] make {get;set;}
    }

    @AuraEnabled(Cacheable=true)
    public static List<Car__c> getCars(Filters filters) {

        String key, whereClause = '';
        Decimal maxPrice;
        String[] categories, make, criteria = new List<String>{};

        if (filters != null) {
            maxPrice = filters.maxPrice;
            categories = filters.categories;
            make = filters.make;
            if (!String.isEmpty(filters.searchKey)) {
                key = '%' + filters.searchKey + '%';
                criteria.add('Name LIKE: key');
            }
            if (filters.maxPrice >= 0) {
                criteria.add('MSRP__c <= :maxPrice');
            }
            if (filters.categories != null) {
                criteria.add('Category__c IN :categories');
            }
            if (filters.make != null) {
                criteria.add('Make__c IN :make');
            }
            if (criteria.size() > 0) {
                whereClause =  'WHERE ' + String.join(criteria, ' AND ');
            }
        }

        String query = 'SELECT Id, Name, MSRP__c, Description__c, Category__c, Control__c, Make__c, Picture_URL__c FROM Car__c' + whereClause + ' WITH SECURITY_ENFORCED' + ' ORDER BY Name';
 
        return Database.query(query);
    }
}
