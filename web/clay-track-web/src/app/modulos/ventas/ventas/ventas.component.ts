import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-ventas',
  templateUrl: './ventas.component.html',
  styleUrls: ['./ventas.component.css'],
  providers: [MessageService]

})
export class VentasComponent {
  
  products!: any[];
  productosAgregar: any[] = [];
  

  visible: boolean = false;

  showDialog() {
    this.visible = true;
  }
  constructor( private messageService: MessageService) { }

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

  }
}