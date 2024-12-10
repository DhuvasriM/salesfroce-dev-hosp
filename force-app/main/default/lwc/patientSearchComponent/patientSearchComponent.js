import { LightningElement, track, wire} from 'lwc';
import getPatientDetails from '@salesforce/apex/PatientController.getPatientDetails';
import PatientLogo_1 from '@salesforce/resourceUrl/PatientLogo_1';


export default class PatientSearchComponent extends LightningElement {
    @track patientName = '';
    @track patientDetails;
    patientLogoUrl=PatientLogo_1;
    

    handleNameChange(event) {
        this.patientName = event.target.value;
    }

    searchPatient() {
        getPatientDetails({ name: this.patientName })
            .then(result => {
                this.patientDetails = result;
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
}