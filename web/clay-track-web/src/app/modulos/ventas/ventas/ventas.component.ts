import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { RecetasService } from 'src/app/servicios/recetas/recetas.service';
import { VentasService } from 'src/app/servicios/ventas/ventas.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-ventas',
  templateUrl: './ventas.component.html',
  styleUrls: ['./ventas.component.css'],
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
export class VentasComponent {
  
  products!: any[];
  productosAgregar: any[] = [];
  columna:string='col-9';
  navBar:boolean=false;
  arrayStock:any[]= new Array();
  arrayReceta: any[]=new Array()
  visible: boolean = false;
  visibleOnlyStock:boolean=false;
  idReceta:number=0
  totalReceta:number=0
  arrayStockPorId:any[]=new Array();
  infomacionProducto:any=[]

  showDialog() {
    this.visible = true;
  }

  showDialogStock() {
    this.visibleOnlyStock = true;
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
  constructor( private messageService: MessageService, private _servicioVentas: VentasService, private _servicioReceta: RecetasService) { 
    this.obtenerStock();
    this.obtenerReceta();
  }

 
  agregarEmpleado() {
    this.visible=false;
    this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el cliente correctamente.' });
  }



  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del cliente.' });
  }

  ngOnInit() {
    this.products = [
      {
        id: '1000',
        code: 'f230fh0g3',
        name: 'Bamboo Watch',
        description: 'Product Description 1',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnGMxLnT6j6RZSTeaJcSH6U3Txe0cFhbxJfA&usqp=CAU',
        price: 65,
        category: 'Accessories',
        quantity: 24,
        inventoryStatus: 'INSTOCK',
        rating: 5,
      },
      {
        id: '1001',
        code: 'jdj232k3g',
        name: 'Leather Wallet',
        description: 'Product Description 2',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnGMxLnT6j6RZSTeaJcSH6U3Txe0cFhbxJfA&usqp=CAU',
        price: 35,
        category: 'Accessories',
        quantity: 10,
        inventoryStatus: 'LOWSTOCK',
        rating: 4,
      },
      {
        id: '1002',
        code: 'mf30gdk3',
        name: 'Smartphone Case',
        description: 'Product Description 3',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnGMxLnT6j6RZSTeaJcSH6U3Txe0cFhbxJfA&usqp=CAU',
        price: 20,
        category: 'Electronics',
        quantity: 0,
        inventoryStatus: 'OUTOFSTOCK',
        rating: 3.5,
      },
      // Agrega más productos aquí
    ];
  }

  agregarCarrito(product: any) {
    // Buscar si el producto ya está en el carrito
    const index = this.productosAgregar.findIndex((item) => item.id === product.id);

    if (index !== -1) {
      // Si el producto ya está en el carrito, aumentar la cantidad
      this.productosAgregar[index].quantity += 1;
      this.calcularSubtotal(this.productosAgregar[index]);
    } else {
      // Si el producto no está en el carrito, agregarlo con cantidad 1
      this.productosAgregar.push({ ...product, quantity: 1, subtotal: product.price });
    }
  }

  eliminarProducto(product: any) {
    // Buscar el índice del producto en el carrito
    const index = this.productosAgregar.findIndex((item) => item.id === product.id);

    if (index !== -1) {
      // Eliminar el producto del carrito
      this.productosAgregar.splice(index, 1);
    }
  }

  modificarCantidad(product: any, increment: number) {
    if (product.quantity + increment >= 1) {
      product.quantity += increment;
      this.calcularSubtotal(product);
    }
  }

  calcularSubtotal(product: any) {
    product.subtotal = product.price * product.quantity;
  }

  calcularTotal(): number {
    return this.productosAgregar.reduce((total, item) => total + item.subtotal, 0);
  }

  agregarStock(){
    this._servicioVentas.agregarStock(this.idReceta, this.totalReceta).subscribe((receta:any)=>{
      this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el stock correctamente.' });
      console.log(receta)
      this.obtenerStock()
    },(err:any)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al guardar el Stock' });

    })
  }

  obtenerStock(){
    // this.loading = true; 
    this._servicioVentas.obtenerStock().subscribe((stock)=>{
      this.arrayStock=stock;
      console.log('Stock',this.arrayStock)
      // this.loading = false; 
    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener el Stock' });
      // this.loading = false; 

    })
  }

  obtenerReceta(){
    this._servicioReceta.obtenerReceta().subscribe((receta)=>{
      this.arrayReceta=receta;
      console.log('RECEYA',this.arrayReceta)
    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener la Receta' });

    })
  }

  obtenerIdEmpleado(id:string){
    this._servicioVentas.obtenerStockPorId(id).subscribe((datosStock)=>{
      this.arrayStockPorId= datosStock;
      console.log('DATOS Stock',datosStock )
    })
  }

  eliminarEmpleado(id: string) {
    // Mostrar SweetAlert de confirmación antes de eliminar el proveedor
    Swal.fire({
      title: 'Confirmación',
      text: '¿Estás seguro de eliminar este Producto?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        // El usuario ha confirmado la eliminación
        this._servicioVentas.eliminarStock(id).subscribe(
          (response) => {
            // Proveedor eliminado con éxito, realizar acciones adicionales si es necesario
            this.messageService.add({ key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se eliminó el Producto correctamente.' });
            console.log('Stock eliminado exitosamente:', response);
            this.obtenerStock(); 
          },
          (error) => {
            // Ocurrió un error al eliminar el proveedor, manejar el error apropiadamente
            this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al eliminar el Stock' });
            console.error('Error al eliminar el apropiadamente:', error);
          }
        );
      }
    });
  }

}