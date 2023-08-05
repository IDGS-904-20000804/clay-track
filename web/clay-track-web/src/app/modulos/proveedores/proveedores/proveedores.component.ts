import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { switchMap } from 'rxjs';
import { ProveedorService, Supplier } from 'src/app/servicios/proveedor/proveedor.service';
import Swal from 'sweetalert2';
import { es } from '../../es';

@Component({
  selector: 'app-proveedores',
  templateUrl: './proveedores.component.html',
  styleUrls: ['./proveedores.component.css'], 
  providers: [MessageService]

})
export class ProveedoresComponent {
  visible: boolean = false;
  arrayProveedor: any[]=new Array();
  idProvedor!:any;
  loading: boolean = true; 
  es = es;
  provedor:Supplier={
    idCatSupplier: 0,
    email: "",
    fkCatPerson: 0,
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
      creationDate: "2023-07-28T03:24:28.696Z",
      updateDate: "2023-07-28T03:24:28.696Z"
    }
  }

  
  showDialog() {
    this.visible = true;
  }
  constructor(private messageService: MessageService, private _servicioProveedor:ProveedorService,private router: Router,private activatedRoute: ActivatedRoute) { 
    this.obtenerProveedor()
  }

  ngOnInit(): void {
    if (!this.router.url.includes('EditarProveedores')) {
      return;
    }

    this.activatedRoute.params.subscribe(params => {
      const idProvedor = +params['id']; // Asegúrate de que el nombre del parámetro coincida con el de la ruta
      this.idProvedor = !isNaN(idProvedor) ? idProvedor : null; // Comprobar si el valor es un número válido
    });
  }

  agregarEmpleado() {
    this.visible=false;
    this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el empleado correctamente.' });
  }



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del empleado.' });
  }

  obtenerProveedor() {
    this.loading = true; 
    this._servicioProveedor.obtenerProveedor().subscribe(
      (proveedor) => {
        this.arrayProveedor = proveedor;
        console.log('Proveedor', this.arrayProveedor);
        this.loading = false; 
      },
      (err) => {
        console.log(err);
        this.loading = false; 
        this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los proveedores' });
      }
    );
  }

  agregarProvedor() {
    this._servicioProveedor.guardarProvedor(this.provedor).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el provedor correctamente.' });
        console.log('Provedor guardado exitosamente:', response);
        this.obtenerProveedor();
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar el provedor:', error);
      }
    );
  }

  modificarProvedor() {
    this._servicioProveedor.actualizarProvedor(this.provedor,this.idProvedor).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el provedor correctamente.' });
        console.log('Provedor guardado exitosamente:', response);
        this.obtenerProveedor();
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar el provedor:', error);
      }
    );
  }
  eliminarProvedor(id: number) {
    // Mostrar SweetAlert de confirmación antes de eliminar el proveedor
    Swal.fire({
      title: 'Confirmación',
      text: '¿Estás seguro de eliminar este proveedor?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        // El usuario ha confirmado la eliminación
        this._servicioProveedor.eliminarProvedor(id).subscribe(
          (response) => {
            // Proveedor eliminado con éxito, realizar acciones adicionales si es necesario
            this.messageService.add({ key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se eliminó el proveedor correctamente.' });
            console.log('Proveedor eliminado exitosamente:', response);
            this.obtenerProveedor(); // Llamar a la función para actualizar la lista de proveedores
          },
          (error) => {
            // Ocurrió un error al eliminar el proveedor, manejar el error apropiadamente
            this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al eliminar el Provedor' });
            console.error('Error al eliminar el proveedor:', error);
          }
        );
      }
    });
  }

  
  
  
}
