import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-materia-prima',
  templateUrl: './materia-prima.component.html',
  styleUrls: ['./materia-prima.component.css'],
  providers: [MessageService],
  animations: [
    trigger('fadeInOut', [
      state('void', style({
        opacity: 0,
        transform: 'translateX(-100%)'
      })),
      state('*', style({
        opacity: 1,
        transform: 'translateX(0)'
      })),
      transition('void <=> *', animate('600ms ease-in-out')),
    ])
  ]

})
export class MateriaPrimaComponent {
  visible: boolean = false;
  columna:string='col-9';
  navBar:boolean=false;
  showDialog() {
    this.visible = true;
  }
  toggleNavBar() {
    if(this.navBar==false){
      this.navBar =true;
      this.columna='col-12';
    }else{
      this.navBar =false;
      this.columna='col-9';
    }
    
  }
  constructor( private messageService: MessageService) { }

  agregarEmpleado() {
    this.visible=false;
    this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo la Materia Prima correctamente.' });
  }



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado de Materia Prima.' });
  }
}
