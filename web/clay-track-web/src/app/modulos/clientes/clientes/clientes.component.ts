import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Client, ClientesService } from 'src/app/servicios/clientes/clientes.service';
import { LoginService } from 'src/app/servicios/login/login.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.css'],
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
export class ClientesComponent {
  visible: boolean = false;
  arrayClientes: any= new Array();
  usuariId = 1;
  fecha = new Date().toISOString();
  columna:string='col-9';
  navBar:boolean=false;
  loading: boolean = true;
  cliente: Client = {
    idCatClient: 0,
    fkCatPerson: 0,
    fkUser: "string",
    fkRol: "c309fa92-2123-47be-b397-adfdgdfg3344",
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
      creationDate: "2023-07-28T00:47:02.987Z",
      updateDate: "2023-07-28T00:47:02.987Z"
    },
    user: {
      "id": "string",
      "userName": "string",
      "normalizedUserName": "string",
      "email": "string",
      "normalizedEmail": "string",
      "emailConfirmed": true,
      "passwordHash": "string",
      "securityStamp": "string",
      "concurrencyStamp": "string",
      "phoneNumber": "string",
      "phoneNumberConfirmed": true,
      "twoFactorEnabled": true,
      "lockoutEnd": "2023-08-06T19:29:05.037Z",
      "lockoutEnabled": true,
      "accessFailedCount": 0
    },
    role: {
      id: "c309fa92-2123-47be-b397-adfdgdfg3344",
      name: "",
      normalizedName: "",
      concurrencyStamp: ""
    }
  };

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
  constructor( private messageService: MessageService, private _servicioClientes: ClientesService,private clientService: ClientesService) { 
    this.obtenerClientes()
  }

  agregarEmpleado() {
  //   // Set the current date and time to the cliente object before saving.
  // const currentDate = new Date().toISOString();

  // // Set the creationDate and updateDate properties to the current date.
  // this.cliente.person.creationDate = currentDate;
  // this.cliente.person.updateDate = currentDate;
  // this.usuariId++

    // Llamar al servicio para guardar el cliente
    this.clientService.guardarCliente(this.cliente).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el cliente correctamente.' });
        console.log('Cliente guardado exitosamente:', response);
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar el cliente:', error);
      }
    );
  }

  obtenerIdProvedor(id: string){
    this._servicioClientes.obtenerClientePorId(id).subscribe((datosCliente)=>{
      this.cliente= datosCliente;
      console.log('DATOS',datosCliente )
      this.showDialog();
    })
  }

  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del cliente.' });
  }

  obtenerClientes(){
    this.loading = true; 

    this._servicioClientes.obtenerClientes().subscribe((clientes)=>{
      this.arrayClientes=clientes;
      console.log('Clientes',this.arrayClientes)
      this.loading = false; 

    }, (err)=>{
      console.log(err)
      this.loading = false; 
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los clientes' });
    })
  }

  
  agregarCliente() {
    this._servicioClientes.guardarCliente(this.cliente).subscribe(
      (response) => {
        
          this.visible = false;
          this.messageService.add({key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se guardó el cliente correctamente.' });
          console.log('CLIENTE guardado exitosamente:', response); // Acceder al mensaje de éxito
        
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar el cliente:', error);
      }
    );
  }

  eliminarCliente(id: string) {
    // Mostrar SweetAlert de confirmación antes de eliminar el cliente
    Swal.fire({
      title: 'Confirmación',
      text: '¿Estás seguro de eliminar este cliente?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        // El usuario ha confirmado la eliminación
        this._servicioClientes.eliminarCliente(id).subscribe(
          (response) => {
            // cliente eliminado con éxito, realizar acciones adicionales si es necesario
            this.messageService.add({ key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se eliminó el cliente correctamente.' });
            console.log('Cliente eliminado exitosamente:', response);
            this.obtenerClientes(); // Llamar a la función para actualizar la lista de clientees
          },
          (error) => {
            // Ocurrió un error al eliminar el cliente, manejar el error apropiadamente
            this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al eliminar el Cliente' });
            console.error('Error al eliminar el cliente:', error);
          }
        );
      }
    });
  }
}
