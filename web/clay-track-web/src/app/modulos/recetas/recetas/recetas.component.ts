import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-recetas',
  templateUrl: './recetas.component.html',
  styleUrls: ['./recetas.component.css'],
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
export class RecetasComponent {

  visible: boolean = false;
  unidadMedida!:string;
  cantidad!:string;
  arrayMateriaPrima: any[]=  new Array();
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
    this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el empleado correctamente.' });
  }

  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del empleado.' });
  }

  agregarMateria() {
    const recetaExistente = this.arrayMateriaPrima.find(
      (materiaPrima) => materiaPrima.materia === this.unidadMedida
    );
  
    const cantidadNueva = parseFloat(this.cantidad);
  
    if (!isNaN(cantidadNueva) && cantidadNueva > 0) {
      if (recetaExistente) {
        recetaExistente.cantidad += cantidadNueva;
      } else {
        this.arrayMateriaPrima.push({
          materia: this.unidadMedida,
          cantidad: cantidadNueva
        });
      }
      this.unidadMedida = '';
      this.cantidad = '';
    } else {
      this.messageService.add({ key: 'tc',severity: 'info', summary: 'Verifica', detail: 'La cantidad debe ser un número válido mayor que cero.' });
    }
  }
  

  eliminarMateriaP(i: number){
    this.arrayMateriaPrima.splice(i,1)
  }



}
