import { LightningElement ,track} from 'lwc';
import todayapp from '@salesforce/apex/todaysAppoinment.tdysAppoint';

export default class TodaysAppoinment extends LightningElement {

    @track apptointments;


    handleClick(){
        todayapp().then(result=>{
            this.apptointments=result;
        }).catch(error=>{
            console.log(error);
        })



    }
}