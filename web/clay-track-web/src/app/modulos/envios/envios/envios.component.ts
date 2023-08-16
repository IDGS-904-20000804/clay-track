import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { EmpleadosService } from 'src/app/servicios/empleados/empleados.service';
import { EnvioService } from 'src/app/servicios/envio/envio.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-envios',
  templateUrl: './envios.component.html',
  styleUrls: ['./envios.component.css'],
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
export class EnviosComponent {
  visible: boolean = false;
  columna:string='col-9';
  navBar:boolean=false;
  arrayEnvios:any[]=new Array()
  arrayEnviosDetalle:any

  arrayEmpleados:any[]=new Array()
  loading:boolean=false
  entregados: boolean = false;

  // Función para cambiar el estado del botón
  toggleEntregados() {
    this.entregados = !this.entregados;
    this.obtenerDatosArray()
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
  constructor(private messageService: MessageService, private _servicioEnvio:EnvioService, private _servicioEmpleados: EmpleadosService) { 

    this.obtenerEnvios()
    this.obtenerEmpleados()
  }

  agregarEmpleado() {
    this.visible=false;
    this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el empleado correctamente.' });
  }



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del empleado.' });
  }

  obtenerDatosArray()
  {
    if(this.entregados){
      this.obtenerActivos()

    }else{
      this.obtenerEnvios()
    }
  }

  obtenerEnvios(){
    this.loading=true
    this._servicioEnvio.obtenerEnvio().subscribe((envios)=>{
      this.arrayEnvios=envios
      console.log(this.arrayEnvios)
      this.loading=false
    },(err)=>{
      this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Error al cargar envio' });
      this.loading=false
    })
  }

  obtenerActivos(){
    this.loading=true
    this._servicioEnvio.obtenerActivos().subscribe((envios)=>{
      this.arrayEnvios=envios
      console.log(this.arrayEnvios)
      this.loading=false
    },(err)=>{
      this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Error al cargar envio' });
      this.loading=false
    })
  }

  obtenerEmpleados(){
    this._servicioEmpleados.obtenerEmpleados().subscribe((empleados:any)=>{
      this.arrayEmpleados=empleados;
      console.log('Empleados',this.arrayEmpleados)
    }, (err:any)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los empleados' });
    })
  }

  obtenerEnviosDetalle(id:string){
    this._servicioEnvio.obtenerDetalleEnvio(id).subscribe((envios)=>{
      this.arrayEnviosDetalle=envios
      console.log(this.arrayEnviosDetalle)
      this.visible=true
      this.obtenerEnvios()
    },(err)=>{
      this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Error al cargar detalle envio' });
    })
  }
  // En tu componente TypeScript

calcularTotal(envio: any): number {
  let total = 0;
  for (const detalle of envio.detailSale) {
    total += detalle.price;
  }
  return total;
}
// En tu componente TypeScript

calcularTotalGeneral(): number {
  let totalGeneral = 0;
  for (const envio of this.arrayEnviosDetalle) {
    totalGeneral += this.calcularTotal(envio);
  }
  return totalGeneral;
}

enviarPedido(id: string) {
  // Mostrar SweetAlert de confirmación antes de eliminar el cliente
  Swal.fire({
    title: 'Confirmación',
    text: '¿Estás seguro de enviar este pedido?',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Sí, enviar',
    cancelButtonText: 'Cancelar'
  }).then((result) => {
    if (result.isConfirmed) {
      // El usuario ha confirmado la eliminación
      this._servicioEnvio.enviarEnvio(id).subscribe(
        (response) => {
          // cliente eliminado con éxito, realizar acciones adicionales si es necesario
          this.messageService.add({ key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se envio el pedido correctamente.' });
          console.log('Enviado exitosamente:', response);
          this.obtenerEnvios(); // Llamar a la función para actualizar la lista de clientees
        },
        (error) => {
          // Ocurrió un error al eliminar el cliente, manejar el error apropiadamente
          this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al enviar el pedido' });
          console.error('Error al enviar el pedido:', error);
        }
      );
    }
  });
}


}
