import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:valkiera/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier {
  final String serverIpAddress =
      '192.168.137.183'; // Cambia a la dirección IP de tu servidor
  final int serverPort = 7106; // Cambia al puerto que estás utilizando
  final List<Product> products = [];
  late final String _baseUrl;
  List<Product> filteredProducts = [];

  late Product selectedProduct;
  final storage = const FlutterSecureStorage();
  bool isLoading = true;
  bool isSaving = false;
  List<String> filterOptions = ['Todos', 'Activos', 'Inactivos'];
  String currentFilter = 'Todos';

  ProductsServices() {
    _baseUrl = '$serverIpAddress:$serverPort';
    loadProducts().then((_) {
      // Cargar todos los productos en la lista de productos filtrados al iniciar
      filteredProducts = List.from(products);
      isLoading = false;
      notifyListeners();
    });
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final token = await storage.read(key: 'token') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final url = Uri.https(_baseUrl, '/api/Stock/GetAll');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> productsList = json.decode(response.body);
        print(productsList);
        for (var productData in productsList) {
          final tempProduct = Product.fromJson(productData);

          // Cambia 'idCatRecipe' para reflejar el nombre correcto en tu clase Product
          tempProduct.idCatRecipe = productData['idCatRecipe'];

          products.add(tempProduct);
        }
      } else if (response.statusCode == 401) {
        // Manejar el error de autenticación
        // Puedes mostrar una notificación o redirigir a la pantalla de inicio de sesión
      } else {
        // Manejar otros códigos de estado
      }
    } catch (error) {
      // Manejar errores de red u otros
    }

    isLoading = false;
    notifyListeners();
    return products;
  }

  Future<int> deleteProduct(Product product) async {
    final token = await storage.read(key: 'token') ?? '';
    final url = Uri.https(
      _baseUrl,
      '/api/Stock/Delete${product.idCatRecipe}',
    );

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final resp = await http.put(url, headers: headers);

    if (resp.statusCode == 200) {
      final index = products
          .indexWhere((element) => element.idCatRecipe == product.idCatRecipe);
      products.removeAt(index);

      // Volver a cargar la lista de productos después de eliminar
      await loadProducts();

      // Notificar a los escuchadores sobre el cambio
      notifyListeners();

      // Devolver el ID del producto eliminado
      return product.idCatRecipe;
    } else {
      throw Exception('Error al eliminar el producto');
    }
  }

  void filterProductsByName(String name) {
    if (name.isEmpty) {
      // Si el campo de búsqueda está vacío, mostrar todos los productos
      filteredProducts = List.from(products);
    } else {
      // Filtrar productos por nombre
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void cycleFilter(String filterType) {
    if (filterType == 'Todos') {
      filteredProducts = products;
    } else if (filterType == 'Activos') {
      filteredProducts =
          // ignore: unrelated_type_equality_checks
          products.where((product) => product.status == true).toList();
    } else if (filterType == 'Inactivos') {
      filteredProducts =
          // ignore: unrelated_type_equality_checks
          products.where((product) => product.status == false).toList();
    }

    int currentIndex = filterOptions.indexOf(filterType);
    int nextIndex = (currentIndex + 1) % filterOptions.length;
    currentFilter = filterOptions[nextIndex];
    notifyListeners();
  }
}
