import { api, LightningElement, track } from 'lwc';
import LightningAlert from 'lightning/alert';
import insertC1Excel from '@salesforce/apex/C1_Apex.insertC1Excel';
export default class FileUploadData extends LightningElement {
    openFileUpload(event){
        let splitObjectInIndex = [];
        let arrayFinal = [];
        this.template.querySelector("lightning-button").addEventListener("click",function(){
            if(splitObjectInIndex.length==0){
                LightningAlert.open({
                    message: 'this is the alert message',
                    theme: 'error', // a red theme intended for error states
                    label: 'Error!', // this is the header text
                });
            }else{
                arrayFinal.map(data=>{
                    let randomNumber = Math.floor(Math.random() * 90) + 10;
                    insertC1Excel(
                        {
                            Name: data[0]+randomNumber,contact:data[1],acc:data[2]
                        }
                    ).then(result=>{
                        console.log(result)
                    })
                    console.log(`arrayFinal = ${data}`)
                })
            }
        });
        const file = event.target.files[0]
        const fileReader = new FileReader();
        fileReader.onload = function (e){
            const content = e.target.result;
            const splitContent = content.split("\n");
             splitObjectInIndex= splitContent.map(data=>
                (
                    data.split(";")                        
                ));

           
            splitObjectInIndex.
                slice(1,splitObjectInIndex.length).
                    forEach(element => {
                        // console.log(element)
                        arrayFinal.push(element.slice(0,element.length-1).map(elm =>{
                            return elm.replace(/\s+/g, '');
                        }))
                    }
                );
            
        }
        fileReader.readAsText(file)
    }
    onClick(){

    }
}