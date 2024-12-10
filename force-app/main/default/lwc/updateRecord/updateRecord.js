import { LightningElement, wire } from 'lwc';
import getPatientList from '@salesforce/apex/PatientController.getPatientList';
import { updateRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import {refreshApex} from '@salesforce/apex';

const columns=[
    {label:'First Name', fieldName:'First_Name__c', editable:true},
    {label:'Last Name', fieldName:'Last_Name__c', editable:true},
    {label:'Phone', fieldName:'Contact_Number__c', editable:true},
    {label:'Email', fieldName:'Patient__c', editable:true},
    {label:'Address', fieldName:'Address__c', editable:true},
    {label:'Emergency Contact Email', fieldName:'Emergency_Contact_Email__c', editable:true},
]

export default class UpdateRecord extends LightningElement {
    
    @wire(getPatientList)
    patientList

   
    columns=columns;
    draftValues=[];
    saveHandler(event){
        console.log(event.detail.draftValues);
        const recordInputs=event.detail.draftValues.slice().map(draft=>{
            const fields=Object.assign({},draft);
            return {fields};
        })
        
    console.log('recordInputs',recordInputs);
    const promises=recordInputs.map(rec=>updateRecord(rec));

    Promise.all(promises).then(result=>{
        this.showToastMsg('Success', 'Patient\'s Detail updated')
        this.draftValues=[]
        return refreshApex(this.patientList);
    }).catch(error=>{
        this.showToastMsg('Error creating record', error.body.message)
    })
}
    showToastMsg(title, message){
        this.dispatchEvent(new ShowToastEvent({
            title:title,
            message:message,
            variant:'Success'
        }))
    }
}