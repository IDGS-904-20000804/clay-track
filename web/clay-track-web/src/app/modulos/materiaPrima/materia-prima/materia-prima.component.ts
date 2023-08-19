import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { MateriaPrimaService, RawMaterial } from 'src/app/servicios/materiaPrima/materia-prima.service';
import Swal from 'sweetalert2';

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
  loading: boolean = true; 
  arrayMateriaPrima: any[]=new Array();
  materiaP:RawMaterial={
    "idCatRawMaterial": 0,
    "name": "",
    "quantityWarehouse": 0,
    "quantityPackage": 0,
    "status": true,
    "creationDate": "2023-08-06T04:46:56.147Z",
    "updateDate": "2023-08-06T04:46:56.147Z",
    "fkCatUnitMeasure": 0,
    "unitMeasure": {
      "idCatUnitMeasure": 0,
      "description": "",
      "status": true,
      "creationDate": "2023-08-06T04:46:56.147Z",
      "updateDate": "2023-08-06T04:46:56.147Z"
    }
  }

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
  constructor( private messageService: MessageService, private _servicioMateriaP: MateriaPrimaService) { 
    this.obtenerMateriaPrima()
  }

  agregarMateroiaP() {
    if(this.materiaP.idCatRawMaterial>0){
      this.modificarMateriaP()
      this.obtenerMateriaPrima(); 
    }else{
      
    this._servicioMateriaP.guardarMatreriaP(this.materiaP).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo la materia prima correctamente.' });
        console.log('Materia Prima guardado exitosamente:', response);
        this.obtenerMateriaPrima();
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar la materia prima:', error);
      }
    );
    }
  }



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado de Materia Prima.' });
  }

  obtenerMateriaPrima() {
    this.loading = true; 
    this._servicioMateriaP.obtenerMateriaP().subscribe(
      (materiaP) => {
        this.arrayMateriaPrima = materiaP;
        console.log('Materia Prima', this.arrayMateriaPrima);
        this.loading = false; 
      },
      (err) => {
        console.log(err);
        this.loading = false; 
        this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los proveedores' });
      }
    );
  }

  obtenerIdMateriaP(id: string){
    this._servicioMateriaP.obtenerMateriaPPorId(id).subscribe((datoMateriaP)=>{
      this.materiaP= datoMateriaP;
      console.log('DATOS',datoMateriaP )
      this.showDialog();
    })
  }

  modificarMateriaP() {
    this._servicioMateriaP.actualizarMateriaP(this.materiaP,this.materiaP.idCatRawMaterial).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo la materia prima correctamente.' });
        console.log('Materia Prima guardado exitosamente:', response);
        this.obtenerMateriaPrima();
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar la Materia Prima:', error);
      }
    );
  }

  eliminarMateriaP(id: string) {
    // Mostrar SweetAlert de confirmación antes de eliminar el proveedor
    Swal.fire({
      title: 'Confirmación',
      text: '¿Estás seguro de eliminar este materia prima?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        // El usuario ha confirmado la eliminación
        this._servicioMateriaP.eliminarMateriaPrima(id).subscribe(
          (response) => {
            // Proveedor eliminado con éxito, realizar acciones adicionales si es necesario
            this.messageService.add({ key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se eliminó la materia prima correctamente.' });
            console.log('materia prima eliminado exitosamente:', response);
            this.obtenerMateriaPrima(); // Llamar a la función para actualizar la lista de proveedores
          },
          (error) => {
            // Ocurrió un error al eliminar el proveedor, manejar el error apropiadamente
            this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al eliminar el materia prima' });
            console.error('Error al eliminar el materia prima:', error);
          }
        );
      }
    });
  }
}
