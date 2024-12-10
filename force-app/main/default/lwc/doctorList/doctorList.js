import { LightningElement, track } from 'lwc';
import getDoctors from '@salesforce/apex/DoctorController.getDoctors';

export default class DoctorList extends LightningElement {
    @track doctors;
    @track error;

    handleFetchDoctors() {
        getDoctors()
            .then(result => {
                this.doctors = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.doctors = undefined;
            });
    }
}