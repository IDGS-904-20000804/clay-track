import { Component } from '@angular/core';
import { ConfirmEventType, ConfirmationService, MessageService } from 'primeng/api';
import { Empleado, EmpleadosService } from '../../../servicios/empleados/empleados.service';
import { trigger, state, style, transition, animate } from '@angular/animations';
import { HttpErrorResponse } from '@angular/common/http';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-empleados',
  templateUrl: './empleados.component.html',
  styleUrls: ['./empleados.component.css'],
  providers: [ConfirmationService, MessageService],
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
export class EmpleadosComponent {
  visible: boolean = false;
  arrayEmpleados: any[]=new Array();
  columna:string='col-9';
  navBar:boolean=false;
  loading: boolean = true;
  empleado:Empleado ={
    idCatEmployee: 0,
    fkCatPerson: 0,
    fkUser: "1",
    fkRol: "1",
    person: {
      idCatPerson: 0,
      name: "",
      lastName: "",
      middleName: "",
      phone: "",
      postalCode: 0,
      streetNumber: "",
      apartmentNumber: "",
      street: "",
      neighborhood: "",
      status: true,
      creationDate: "2023-07-28T02:29:30.884Z",
      updateDate: "2023-07-28T02:29:30.884Z"
    },
    user: {
      id: "1",
      userName: "",
      email: "",
      passwordHash: "",
    },
    role: {
      id: "1",
      name: "",
      normalizedName: "",
      concurrencyStamp: ""
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
  constructor(private confirmationService: ConfirmationService, 
    private messageService: MessageService,
    private _servicioEmpleados: EmpleadosService) {
      this.obtenerEmpleados()
     }

     agregarEmpleado() {
      if(this.empleado.idCatEmployee>0){
        this.modificarEmpleado()
      }else{
        this._servicioEmpleados.guardarEmpleado(this.empleado).subscribe(
          (response) => {
            
              this.visible = false;
              this.messageService.add({key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se guardó el cliente correctamente.' });
              console.log('Empleado guardado exitosamente:', response.error.text); // Acceder al mensaje de éxito
            
          },
          (error) => {
            // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
            console.error('Error al guardar el empleado:', error);
          }
        );

      }
      
    }

    modificarEmpleado() {
      this._servicioEmpleados.actualizarEmpleado(this.empleado,this.empleado.idCatEmployee).subscribe(
        (response) => {
          // Cliente guardado con éxito, realizar acciones adicionales si es necesario
          this.visible = false;
          this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el empleado correctamente.' });
          console.log('Empleado guardado exitosamente:', response);
          this.obtenerEmpleados();
        },
        (error) => {
          // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
          console.error('Error al guardar el empleado:', error);
        }
      );
    }
    

  obtenerEmpleados(){
    this.loading = true; 
    this._servicioEmpleados.obtenerEmpleados().subscribe((empleados)=>{
      this.arrayEmpleados=empleados;
      console.log('Empleados',this.arrayEmpleados)
      this.loading = false; 
    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los empleados' });
      this.loading = false; 

    })
  }

  obtenerIdEmpleado(id:string){
    this._servicioEmpleados.obtenerEmpleadoPorId(id).subscribe((datosProveedor)=>{
      this.empleado= datosProveedor;
      console.log('DATOS EMPLEADO',datosProveedor )
      this.showDialog();
    })
  }

  eliminarEmpleado(id: string) {
    // Mostrar SweetAlert de confirmación antes de eliminar el proveedor
    Swal.fire({
      title: 'Confirmación',
      text: '¿Estás seguro de eliminar este Empleado?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        // El usuario ha confirmado la eliminación
        this._servicioEmpleados.eliminarEmpleado(id).subscribe(
          (response) => {
            // Proveedor eliminado con éxito, realizar acciones adicionales si es necesario
            this.messageService.add({ key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se eliminó el Empleado correctamente.' });
            console.log('Empleado eliminado exitosamente:', response);
            this.obtenerEmpleados(); // Llamar a la función para actualizar la lista de proveedores
          },
          (error) => {
            // Ocurrió un error al eliminar el proveedor, manejar el error apropiadamente
            this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al eliminar el Empleado' });
            console.error('Error al eliminar el Empleado:', error);
          }
        );
      }
    });
  }



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del empleado.' });
  }

}
