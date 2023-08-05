import { Component } from '@angular/core';
import { ConfirmEventType, ConfirmationService, MessageService } from 'primeng/api';
import { EmpleadosService, Employee } from '../../../servicios/empleados/empleados.service';
import { trigger, state, style, transition, animate } from '@angular/animations';

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
  empleado:Employee={
    idCatEmployee: 0,
    fkCatPerson: 0,
    fkUser: "1",
    fkRol: "1",
    person: {
      idCatPerson: 0,
      name: "string",
      lastName: "string",
      middleName: "string",
      phone: "string",
      postalCode: 0,
      streetNumber: "string",
      apartmentNumber: "string",
      street: "string",
      neighborhood: "string",
      status: true,
      creationDate: "2023-07-28T02:29:30.884Z",
      updateDate: "2023-07-28T02:29:30.884Z"
    },
    user: {
      id: "1",
      userName: "string",
      normalizedUserName: "string",
      email: "string",
      normalizedEmail: "string",
      emailConfirmed: true,
      passwordHash: "string",
      securityStamp: "string",
      concurrencyStamp: "string",
      phoneNumber: "string",
      phoneNumberConfirmed: true,
      twoFactorEnabled: true,
      lockoutEnd: "2023-07-28T02:29:30.884Z",
      lockoutEnabled: true,
      accessFailedCount: 0
    },
    role: {
      id: "1",
      name: "string",
      normalizedName: "string",
      concurrencyStamp: "string"
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
    this._servicioEmpleados.guardarEmpleado(this.empleado).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el cliente correctamente.' });
        console.log('Empleado guardado exitosamente:', response);
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar el empleado:', error);
      }
    );
  }

  obtenerEmpleados(){
    this._servicioEmpleados.obtenerEmpleados().subscribe((empleados)=>{
      this.arrayEmpleados=empleados;
      console.log('Empleados',this.arrayEmpleados)
    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los empleados' });
    })
  }



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del empleado.' });
  }

}
