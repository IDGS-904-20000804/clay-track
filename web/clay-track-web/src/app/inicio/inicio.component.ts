import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import Swal from 'sweetalert2';
import { Client, ClientesService } from '../servicios/clientes/clientes.service';

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css'],
  providers: [MessageService],
})
export class InicioComponent {


  irInicioSesion(){
    this.router.navigate(['/InicioSesion']);
  }

  registrarse(){
    this.router.navigate(['/Registro']);
  }
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
    fkUser: "1",
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
      "id": "1",
      "userName": "",
      "email": "",
      "passwordHash": "",
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
  constructor( private router:Router,private messageService: MessageService, private _servicioClientes: ClientesService,private clientService: ClientesService) { 
  }

  agregarEmpleado() {
  
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
    if (
      this.cliente.person.name &&
      this.cliente.person.lastName &&
      this.cliente.person.phone &&
      this.cliente.person.street &&
      this.cliente.person.neighborhood &&
      this.cliente.person.streetNumber &&
      this.cliente.person.postalCode &&
      this.cliente.user.email &&
      this.cliente.user.passwordHash
  ) {
    if(this.cliente.idCatClient>0){
      this.modificarClientes()
      this.obtenerClientes()  
    }else{
    this._servicioClientes.guardarCliente(this.cliente).subscribe(
      (response) => {
          this.visible = false;
          this.messageService.add({key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se guardó el cliente correctamente.' });
          console.log('CLIENTE guardado exitosamente:', response); // Acceder al mensaje de éxito      
          this.obtenerClientes()  
      },
      (error) => {
        console.error('Error al guardar el cliente:', error);
      }
    );
    }
  }else {
    this.messageService.add({ severity: 'info', summary: 'Ops..', detail: 'Por favor, completa todos los campos.' });
  }




  }

  modificarClientes() {
    this._servicioClientes.actualizarCliente(this.cliente,this.cliente.idCatClient).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el provedor correctamente.' });
        console.log('Provedor guardado exitosamente:', response);
        this.obtenerClientes();
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar el provedor:', error);
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

