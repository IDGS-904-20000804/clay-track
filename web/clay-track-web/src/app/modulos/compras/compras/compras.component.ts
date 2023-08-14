import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { CompraService, PurchaseData } from 'src/app/servicios/compra/compra.service';
import { Empleado, EmpleadosService } from '../../../servicios/empleados/empleados.service';
import { ProveedorService } from 'src/app/servicios/proveedor/proveedor.service';
import { RecetasService } from 'src/app/servicios/recetas/recetas.service';
import { MateriaPrimaService } from 'src/app/servicios/materiaPrima/materia-prima.service';


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
  loading: boolean = true;

  arrayCompra: any[]=  new Array();
  arrarCompraServicio:any[]=  new Array();
  arrayEmpleados:any[]=new Array()
  arrayProveedor : any[]=new Array()
  arrayMateriaPrimaSelector: any[]=new Array()
  columna:string='col-9';
  navBar:boolean=false;
  compra:PurchaseData={
    "idCatPurchase": 0,
    "total": 0,
    "fkCatSupplier": 3,
    "fkCatEmployee": 20,
    "rawMaterials": [
      {
        "idCatalog": 0,
        "quantity": 100,
        "price": 30,
        "fkCatRawMaterial": 10
      }
     
    ]
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
  constructor( private messageService: MessageService, 
               private _servicioCompra: CompraService, 
               private _servicioProveedor: ProveedorService,
               private _servicioEmpleados:EmpleadosService,
               private _servicioMateriaP: MateriaPrimaService) { 
    this.obtenerCompra();
    this.obtenerProveedor();
    this.obtenerEmpleados();
    this.obtenerMateriaPrima()
  }

  agregarEmpleado() {
    this.visible=false;
    this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el empleado correctamente.' });
  }

  guardarCompra() {
      this._servicioCompra.guardarCompra(this.compra).subscribe(
        (response) => {
            this.visible = false;
            this.messageService.add({key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se guardó la compra correctamente.' });
            console.log('Compra guardado exitosamente:', response.error.text); // Acceder al mensaje de éxito
          
        },
        (error) => {
          // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
          console.error('Error al guardar la compra:', error);
        }
      );

    
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
          idCatalog:0,
          fkCatRawMaterial: this.materiaP,
          quantity: cantidadNueva,
          price : this.precio,
          // fechaC:this.fechaC
          
        });
      }
    } else {
      this.messageService.add({ key: 'tc',severity: 'info', summary: 'Verifica', detail: 'La cantidad debe ser un número válido mayor que cero.' });
    }
  }
  

  eliminarCompra(i: number){
    this.arrayCompra.splice(i,1)
  }

  obtenerCompra(){
    this.loading = true; 
    this._servicioCompra.obtenerCompra().subscribe((compra)=>{
      this.arrarCompraServicio=compra;
      console.log('Compra',this.arrarCompraServicio)
      this.loading = false; 

    }, (err)=>{
      console.log(err)
      this.loading = false; 

      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los compra' });
    })
  }

  obtenerProveedor() {
    this._servicioProveedor.obtenerProveedor().subscribe(
      (proveedor) => {
        this.arrayProveedor = proveedor;
        console.log('Proveedor', this.arrayProveedor);
      },
      (err) => {
        console.log(err);
        this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los proveedores' });
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

  obtenerMateriaPrima() {
    this._servicioMateriaP.obtenerMateriaP().subscribe(
      (materiaP) => {
        this.arrayMateriaPrimaSelector = materiaP;
        console.log('Materia Prima', this.arrayMateriaPrimaSelector);
      },
      (err) => {
        console.log(err);
        this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener la materia prima' });
      }
    );
  }

}
