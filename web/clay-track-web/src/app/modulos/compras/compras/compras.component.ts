import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { CompraService } from 'src/app/servicios/compra/compra.service';

@Component({
  selector: 'app-compras',
  templateUrl: './compras.component.html',
  styleUrls: ['./compras.component.css'],
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
export class ComprasComponent {
  visible: boolean = false;
  provedor!:string;
  empleado!:string;
  materiaP!:string;
  cantidad!:string;
  precio!:string;
  fechaC!:string;
  arrayCompra: any[]=  new Array();
  arrarCompraServicio:any[]=  new Array();
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
  constructor( private messageService: MessageService, private _servicioCompra: CompraService) { 
    this.obtenerCompra()
  }

  agregarEmpleado() {
    this.visible=false;
    this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el empleado correctamente.' });
  }



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del empleado.' });
  }

  agregarCompra() {
    const recetaExistente = this.arrayCompra.find(
      (compra) => compra.materia === this.materiaP
    );
  
    const cantidadNueva = parseFloat(this.cantidad);
  
    if (!isNaN(cantidadNueva) && cantidadNueva > 0) {
      if (recetaExistente) {
        recetaExistente.cantidad += cantidadNueva;
      } else {
        this.arrayCompra.push({
          materia: this.materiaP,
          cantidad: cantidadNueva,
          precio : this.precio,
          fechaC:this.fechaC
        });
      }
      this.materiaP = '';
      this.cantidad= '';
      this.precio= '';
      this.fechaC= '';
    } else {
      this.messageService.add({ key: 'tc',severity: 'info', summary: 'Verifica', detail: 'La cantidad debe ser un número válido mayor que cero.' });
    }
  }
  

  eliminarCompra(i: number){
    this.arrayCompra.splice(i,1)
  }

  obtenerCompra(){
    this._servicioCompra.obtenerCompra().subscribe((compra)=>{
      this.arrarCompraServicio=compra;
      console.log('Compra',this.arrarCompraServicio)
    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los compra' });
    })
  }
}
