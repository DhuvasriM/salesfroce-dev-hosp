import { LightningElement, api, wire, track } from 'lwc';
import getAppointmentsByDoctor from '@salesforce/apex/AppointmentController.getAppointmentsByDoctor';

export default class DoctorAppointments extends LightningElement {
    @api recordId; // Automatically provided by the Lightning framework
    @track appointments;
    @track error;
    @track errorMessage;

    @wire(getAppointmentsByDoctor, { doctorId: '$recordId' })
    wiredAppointments({ error, data }) {
        if (data) {
            this.appointments = data;
            this.error = undefined;
            this.errorMessage = undefined;
        } else if (error) {
            this.error = error;
            this.appointments = undefined;
            this.errorMessage = this.reduceErrors(error);
        }
    }

    reduceErrors(errors) {
        if (Array.isArray(errors)) {
            return errors
                .map(error => (error.message ? error.message : error.body.message))
                .join(', ');
        }
        return errors.message ? errors.message : errors.body.message;
    }
}