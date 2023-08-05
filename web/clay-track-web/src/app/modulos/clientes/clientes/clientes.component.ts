import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { Client, ClientesService } from 'src/app/servicios/clientes/clientes.service';
import { LoginService } from 'src/app/servicios/login/login.service';

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
  cliente: Client = {
    idCatClient: 0,
    fkCatPerson: 0,
    fkUser: "string",
    fkRol: "",
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
      id: "string",
      userName: "",
      normalizedUserName: "",
      email: "",
      normalizedEmail: "",
      emailConfirmed: true,
      passwordHash: "",
      securityStamp: "",
      concurrencyStamp: "",
      phoneNumber: "",
      phoneNumberConfirmed: true,
      twoFactorEnabled: true,
      lockoutEnd:  "2023-07-28T00:47:02.987Z",
      lockoutEnabled: true,
      accessFailedCount: 0
    },
    role: {
      id: "",
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



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del cliente.' });
  }

  obtenerClientes(){
    this._servicioClientes.obtenerClientes().subscribe((clientes)=>{
      this.arrayClientes=clientes;
      console.log('Clientes',this.arrayClientes)
    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los clientes' });
    })
  }
}
