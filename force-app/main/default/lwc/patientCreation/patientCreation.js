import { LightningElement } from 'lwc';
import LastName_field from '@salesforce/schema/Patient__c.Last_Name__c';
import Age_field from '@salesforce/schema/Patient__c.Age__c';
import Contact_field from '@salesforce/schema/Patient__c.Contact_Number__c';
import EmerEmail_field from '@salesforce/schema/Patient__c.Emergency_Contact_Email__c';
import PatEmail_field from '@salesforce/schema/Patient__c.Patient__c';
import Admitted_field from '@salesforce/schema/Patient__c.Date_Admitted__c';
import Discharged_field from '@salesforce/schema/Patient__c.Date_Discharged__c';
import BillPaid_field from '@salesforce/schema/Patient__c.Bill_Paid__c';

import patient_object from '@salesforce/schema/Patient__c';
import { createRecord } from 'lightning/uiRecordApi';

export default class PatientCreation extends LightningElement {

    lname;
    
    age;
    contact;
    patemail;
    emerEmail;
    admittedDate;
    dischargedDate;
    billCheck;


    patId;

    handleNameChange(event){

        this.lname=event.target.value

    }

    handleAgeChange(event){

        this.age=event.target.value

    }

    

    handleContactChange(event){

        this.contact=event.target.value

    }

    pathandleEmailChange(event){

        this.patemail=event.target.value

    }

    emerhandleEmailChange(event){

        this.emerEmail=event.target.value

    }
    handleAdmittedChange(event){

        this.admittedDate=event.target.value
    }

    handleDischargedChange(event){
        this.dischargedDate=event.target.value;
    }

    handleBillChange(event){
        this.billCheck=event.target.checked;
        console.log(this.billCheck+"billchek");

    }


    createPat(){

        const fields = {};
        fields[LastName_field.fieldApiName] = this.lname;
        fields[Age_field.fieldApiName] = this.age;
        
        fields[Contact_field.fieldApiName] = this.contact;
        fields[EmerEmail_field.fieldApiName] = this.emerEmail;
        fields[PatEmail_field.fieldApiName] = this.patemail;
        fields[Admitted_field.fieldApiName] = this.admittedDate;
        fields[Discharged_field.fieldApiName] = this.dischargedDate;
        fields[BillPaid_field.fieldApiName] = this.billCheck;

        const recordInput = { apiName: patient_object.objectApiName, fields };
        createRecord(recordInput)
            .then(response => {
                alert('Patient created successfully');
                this.patId=response.id;
                
            })
            .catch(error => {
                alert('Error creating patient record');
                console.log(error);
            });
    }






}