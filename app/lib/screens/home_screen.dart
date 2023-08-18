import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valkiera/models/models.dart';
import 'package:valkiera/services/services.dart';
import 'package:valkiera/widgets/widgets.dart';

import 'loading_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsServices>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(17, 90, 133, 1),
        title: const Center(child: Text('Productos')),
        actions: [
          IconButton(
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(17, 90, 133, 1),
                hintText: 'Buscar Producto',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Filtrar productos por nombre
                productService.filterProductsByName(value);
              },
            ),
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  productService.cycleFilter('Todos');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF115A85), // Color azul
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Esquinas redondeadas
                  ),
                ),
                icon: Icon(Icons.all_inclusive,
                    color: Colors.white), // Icono para "Todos"
                label: Text('Todos'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  productService.cycleFilter('Activos');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF00A859), // Color verde
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Esquinas redondeadas
                  ),
                ),
                icon: Icon(Icons.check_circle,
                    color: Colors.white), // Icono para "Activos"
                label: Text('Activos'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  productService.cycleFilter('Inactivos');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF65129), // Color rojo
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Esquinas redondeadas
                  ),
                ),
                icon: Icon(Icons.cancel,
                    color: Colors.white), // Icono para "Inactivos"
                label: Text('Inactivos'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productService.filteredProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final product = productService.filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    productService.selectedProduct = product;
                    Navigator.pushNamed(context, 'product');
                  },
                  child: ProductCard(product: product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
