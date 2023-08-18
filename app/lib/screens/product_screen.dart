import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:valkiera/services/notifications_service.dart';
import 'package:valkiera/providers/product_form_provider.dart';
import 'package:valkiera/services/services.dart';
import 'package:valkiera/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService =
        Provider.of<ProductsServices>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    required this.productService,
  });

  final ProductsServices productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.filePath),
                //TODO boton de back
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
                //Boton de imagen
              ],
            ),
            _ProductForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    final productService = ProductsServices();
    final String customErrorMessage =
        'Hubo un error en el servidor. Por favor, inténtalo más tarde.';

    Future<void> _showConfirmationDialog(BuildContext context) async {
      bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar'),
            content:
                Text('¿Estás seguro de que deseas eliminar este producto?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    int deletedProductId =
                        await productService.deleteProduct(product);
                    Navigator.pop(context, true);

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    // Simular una pequeña espera (opcional)
                    // await Future.delayed(Duration(seconds: 1));

                    // Redirigir al usuario al listado de productos
                    Navigator.pushReplacementNamed(context, 'home');
                  } catch (error) {
                    // Manejar el error en caso de que la eliminación falle
                  }
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );

      if (confirm == true) {
        // Producto eliminado exitosamente
      } else {
        // Cancelación de eliminación
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 550,
        decoration: _BuildDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                readOnly: true, // Agregado para hacer el campo de solo lectura
                decoration: InputDecoration(
                  hintText: 'Nombre del Producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                readOnly: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d+)?\.?\d{0,2}'),
                  ),
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El precio es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '\$230',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.quantityStock}',
                readOnly: true, // Agregado para hacer el campo de solo lectura
                decoration: const InputDecoration(
                  hintText: '12',
                  labelText: 'Stock Total',
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Colores'),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: product.colorHexadecimals.map((colorHex) {
                      return Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Color(
                              int.parse(colorHex.replaceAll("#", "0xFF"))),
                          border: Border.all(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              const SizedBox(height: 30),
              if (product.status == true)
                ElevatedButton.icon(
                  onPressed: () async {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmar'),
                          content: Text(
                              '¿Estás seguro de que deseas eliminar este producto?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context, true);
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      try {
                        // Mostrar un indicador de carga mientras se realiza la eliminación
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        int deletedProductId =
                            await productService.deleteProduct(product);

                        // Cerrar el indicador de carga
                        Navigator.pop(context);

                        // Mostrar notificación de éxito
                        NotificationsService.showSnackBar(
                          'Producto eliminado con éxito',
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );

                        // Pequeño retraso para dar tiempo a la notificación a mostrarse
                        await Future.delayed(Duration(milliseconds: 500));

                        // Redirigir al usuario a la página de inicio
                        Navigator.pushReplacementNamed(context, 'home');
                      } catch (error) {
                        // Manejar el error en caso de que la eliminación falle
                        // También asegúrate de cerrar el indicador de carga en caso de error
                        Navigator.pop(context);
                        // Mostrar notificación de error
                        NotificationsService.showSnackBar(
                          'Error al eliminar el producto',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    } else {
                      // Cancelación de eliminación
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Color rojo
                  ),
                  icon: Icon(Icons.delete),
                  label: Text('Eliminar'),
                ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// class _ProductForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productForm = Provider.of<ProductFormProvider>(context);
//     final product = productForm.product;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         width: double.infinity,
//         height: 300,
//         decoration: _BuildDecoration(),
//         child: Form(
//             key: productForm.formKey,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: Column(
//               children: [
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   initialValue: product.name,
//                   onChanged: (value) => product.name = value,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'El nombre es obligatorio';
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     hintText: 'Nombre del Producto',
//                     labelText: 'Nombre',
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 TextFormField(
//                   initialValue: '${product.price}',
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(
//                         RegExp(r'^(\d+)?\.?\d{0,2}'))
//                   ],
//                   onChanged: (value) {
//                     if (double.tryParse(value) == null) {
//                       product.price = 0;
//                     } else {
//                       product.price = double.parse(value);
//                     }
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'El nombre es obligatorio';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     hintText: '\$230',
//                     labelText: 'Precio',
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 SwitchListTile.adaptive(
//                   value: product.available,
//                   title: const Text('Disponible'),
//                   activeColor: Colors.indigo,
//                   onChanged: productForm.updateAvailability,
//                 ),
//                 const SizedBox(height: 30)
//               ],
//             )),
//       ),
//     );
//   }

// ignore: non_constant_identifier_names
BoxDecoration _BuildDecoration() => const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 5),
        ]);
