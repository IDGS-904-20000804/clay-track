import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = '192.168.137.183:7106';
  final storage = const FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      "username": email,
      "password": password,
    };

    final jsonData = json.encode(authData);

    final url = Uri.https(_baseUrl, '/api/Account/Login');

    try {
      final response = await http.post(
        url,
        body: jsonData,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;

        // if (decodedResponse.containsKey('jwtToken')) {
        //   final token = decodedResponse['jwtToken'] as String;
        //   await storage.write(key: 'token', value: token);
        //   return null;
        // } else if (decodedResponse.containsKey('message')) {
        //   return decodedResponse['message'] as String;
        // }
        if (decodedResponse.containsKey('jwtToken')) {
          final token = decodedResponse['jwtToken'] as String;
          final List<String> parts = token.split('.');
          final String payload =
              utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));

          final Map<String, dynamic> tokenData = json.decode(payload);
          final String email = tokenData[
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'];
          final String role = tokenData[
              'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
          final int expirationTime = tokenData['exp'];
          final String issuer = tokenData['iss'];
          final String audience = tokenData['aud'];

          print('Email: $email');
          print('Role: $role');
          print('Expiration Time: $expirationTime');
          print('Issuer: $issuer');
          print('Audience: $audience');

          if (role == 'Employee') {
            await storage.write(key: 'token', value: token);
            return null;
          } else {
            return 'Lo sentimos no cuentas con los permisos para acceder';
          }
        } else if (decodedResponse.containsKey('message')) {
          return decodedResponse['message'] as String;
        }
      } else if (response.statusCode == 400) {
        return 'Credenciales inválidas. Por favor, verifica tu correo y contraseña.';
      } else if (response.statusCode >= 401 && response.statusCode < 600) {
        final reasonPhrase = response.reasonPhrase;
        final responseBody = response.body;
        final errorMessage = reasonPhrase ?? 'Error en la solicitud';
        return 'Error (${response.statusCode}): $errorMessage\nResponse Body: $responseBody';
      } else {
        return 'Error en la solicitud (${response.statusCode})';
      }
    } catch (error) {
      return 'Error: $error';
    }
    return 'Error desconocido';
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
