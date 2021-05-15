import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import CAR_OBJECT from '@salesforce/schema/Car__c';

// Car Schema
import CATEGORY_FIELD from '@salesforce/schema/Car__c.Category__c';
import MAKE_FIELD from '@salesforce/schema/Car__c.Make__c';

// Constants
const CATEGORY_ERROR = 'Error Loading Categories';
const MAKE_ERROR = 'Error Loading Makes';


export default class CarFilter extends LightningElement {

    filters={
        searchKey: '',
        maxPrice: 1000000
    }

    categoryError = CATEGORY_ERROR;
    makeError = MAKE_ERROR;

    // Fetching Car object
    @wire(getObjectInfo, {objectApiName:CAR_OBJECT})
    carObjectInfo

    // Fetching Category Picklist
    @wire(getPicklistValues, {
        recordTypeId:'$carObjectInfo.data.defaultRecordTypeId',
        fieldApiName:CATEGORY_FIELD
    })categories

    // Fetching Make Picklist
    @wire(getPicklistValues, {
        recordTypeId:'$carObjectInfo.data.defaultRecordTypeId',
        fieldApiName:MAKE_FIELD
    })makes

    // Search Key Handler
    handleSearchKeyChange(event) {
        console.log(event.target.value);
        this.filters = {...this.filters, "searchKey":event.target.value};
    }

    // Price Change handler
    handleMaxPriceChange(event) {
        console.log(event.target.value);
        this.filters = {...this.filters, "maxPrice":event.target.value};
    }

    handleCheckboxChange(event) {
        const {name,value} = event.target.dataset;
        console.log("name: ", name);
        console.log("value: ", value);
    }

}