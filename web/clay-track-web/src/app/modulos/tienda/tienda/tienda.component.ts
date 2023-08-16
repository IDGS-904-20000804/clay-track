import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { EnvioService } from 'src/app/servicios/envio/envio.service';
import { RecetasService } from 'src/app/servicios/recetas/recetas.service';
import { SaleData, VentasService } from 'src/app/servicios/ventas/ventas.service';

@Component({
  selector: 'app-tienda',
  templateUrl: './tienda.component.html',
  styleUrls: ['./tienda.component.css'],
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
export class TiendaComponent {
  arrayStock:any
  carga:boolean=false
  searchQuery: string = '';
filteredStock: any[] = [];
visible: boolean = false;
productosAgregar: any[] = [];
venta!:SaleData
visibleTarjeta: boolean = false;
arrayEnviosDetalle:any
visibleDetalle:boolean=false






  constructor( private messageService: MessageService, private _servicioEnvio: EnvioService, private _servicioVentas: VentasService, private _servicioReceta: RecetasService) { 
    this.obtenerStock();
  }

  obtenerStock(){
    // this.carga = true; 
    this._servicioVentas.obtenerStock().subscribe((stock)=>{
      this.arrayStock=stock;
      console.log('Stock2',this.arrayStock)
      // this.carga = false; 
      this.filteredStock= this.arrayStock;

    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener el Stock' });
      // this.carga = false; 

    })
  }

  filterStock() {
    this.filteredStock = this.arrayStock.filter((stock:any) =>
        stock.name.toLowerCase().includes(this.searchQuery.toLowerCase())
    );
}

ngOnInit() {
  this.filterStock();
}

// Call this method whenever the searchQuery changes
onSearchQueryChange() {
  this.filterStock();
}

showDialog() {
  this.visible = true;
}

showDialogTarjeta() {
  this.visibleTarjeta = true;
}
agregarCarrito(product: any) {
  // Buscar si el producto ya está en el carrito
  const index = this.productosAgregar.findIndex((item) => item.idCatRecipe === product.idCatRecipe);

  if (index !== -1) {
    this.productosAgregar[index].quantity += 1;
    this.calcularSubtotal(this.productosAgregar[index]);
  } else {
    // Agregar el producto al carrito
    this.productosAgregar.push({ ...product, quantity: 1, subtotal: product.price });
  }

  // Agregar un nuevo objeto al arreglo 'venta'
  

  this.messageService.add({ key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se cargó el producto' });

  console.log(this.productosAgregar);
  console.log(this.venta);
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

crearDetalleSalesArray(): any[] {
  const detalleSalesArray = [];

  for (const product of this.productosAgregar) {
    const detalleSale = {
      quantity: product.quantity,
      fkCatClient: 1,
      fkCatSale: 0,
      fkCatRecipe: product.idCatRecipe
    };

    detalleSalesArray.push(detalleSale);
  }

  return detalleSalesArray;
}

idCliente:any

realizarCompra() {
  this.idCliente= localStorage.getItem('ClientId')

  if(this.idCliente>0){
  this.venta = {
    fkCatClient: 1,
    detailSales: this.crearDetalleSalesArray()
  };

  console.log(this.venta);

  this._servicioVentas.realizarVenta(this.venta).subscribe(
    (venta) => {
      this.messageService.add({ key: 'tc', severity: 'success', summary: 'Exito', detail: 'Exito el pago se cargo con exito' });
    },
    (err) => {
      console.log(err);
      if (err.error === 'Insufficient stock or invalid quantity for recipe.') {
        this.messageService.add({ key: 'tc', severity: 'info', summary: 'Ops..', detail: 'Stock insuficiente o cantidad no válida para la receta.' });
      }
    }
  );
  }else{
    this.messageService.add({ key: 'tc', severity: 'info', summary: 'Ops..', detail: 'Para realizar la compra debes registrate' });
  }
}

cerrarSesion(){
  localStorage.clear()
}


obtenerEnviosDetalle(){
  this.idCliente= localStorage.getItem('ClientId')
  this._servicioEnvio.obtenerDetalleEnvio(this.idCliente).subscribe((envios)=>{
    this.arrayEnviosDetalle=envios
    console.log(this.arrayEnviosDetalle)
    this.visibleDetalle=true
  },(err)=>{
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Error al cargar detalle envio' });
  })
}

}
