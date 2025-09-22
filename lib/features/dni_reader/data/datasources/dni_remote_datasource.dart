import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/dni_model.dart';

abstract class DNIRemoteDataSource {
  /// Envía el DNI al servidor para ser procesado
  /// Throws [ServerException] para todos los errores del servidor
  Future<bool> sendDNI(String dni);
}

class DNIRemoteDataSourceImpl implements DNIRemoteDataSource {
  final http.Client client;

  DNIRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> sendDNI(String dni) async {
    try {
      final response = await client.post(
        Uri.parse('https://example.com/aceptar'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'dni': dni}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw ServerException(
            'Error al enviar DNI. Código: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}