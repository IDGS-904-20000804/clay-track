import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:valkiera/UI/Iinput_decoration.dart';
import 'package:valkiera/providers/login_form_provider.dart';
import 'package:valkiera/services/services.dart';
import 'package:valkiera/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:valkiera/UI/util.dart';
import 'package:valkiera/services/notifications_service.dart'
    as ns; // Usamos 'as ns'

// ... tu código aquí ...

const theme = Color.fromRGBO(17, 90, 133, 1);

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                chilld: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Login',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: _LoginForm()),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintTex: 'ejemplo@gmail.com',
                labelTex: 'Correo',
                prefixIcon: Icons.alternate_email_sharp),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no es un correo ';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintTex: '*********',
                labelTex: 'Password',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                // Validar si el valor es nulo o está vacío
                return 'Debes ingresar una contraseña';
              }
              return null; // La validación es exitosa, retorna null
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: theme,
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;

                    final String? errorMessage = await authService.login(
                      loginForm.email,
                      loginForm.password,
                    );

                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else if (errorMessage == 'ServerError') {
                      String customErrorMessage =
                          'Hubo un error en el servidor. Por favor, inténtalo más tarde.';
                      final localContext = context;

                      // ignore: use_build_context_synchronously
                      Dialogos.msgDialog(
                        context: localContext,
                        dgt: DialogType
                            .ERROR, // Utiliza DialogType.ERROR para mostrar un diálogo de error
                        texto: customErrorMessage,
                        onPress: () {
                          // Aquí puedes agregar cualquier acción que desees después de cerrar el diálogo
                          // Por ejemplo, restablecer el estado isLoading o hacer algo más.
                          loginForm.isLoading = false;
                          Navigator.pushReplacementNamed(localContext, 'login');
                        },
                      ).show();
                      loginForm.isLoading = false;
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'login');
                    } else {
                      String customErrorMessage = errorMessage;
                      final localContext = context;

                      // ignore: use_build_context_synchronously
                      Dialogos.msgDialog(
                        context: localContext,
                        dgt: DialogType
                            .ERROR, // Utiliza DialogType.ERROR para mostrar un diálogo de error
                        texto: customErrorMessage,
                        onPress: () {
                          // Aquí puedes agregar cualquier acción que desees después de cerrar el diálogo
                          // Por ejemplo, restablecer el estado isLoading o hacer algo más.
                          loginForm.isLoading = false;
                          Navigator.pushReplacementNamed(localContext, 'login');
                        },
                      ).show();
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espere..' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
