import '../../../../core/error/exceptions.dart';
import '../models/dni_model.dart';

abstract class DNILocalDataSource {
  /// Escanea un código PDF417 de un DNI y devuelve los datos mapeados
  /// Throws [ScanException] si hay problemas con el escaneo
  Future<DNIModel> scanDNI();
}

class DNILocalDataSourceImpl implements DNILocalDataSource {
  @override
  Future<DNIModel> scanDNI() async {
    try {
      // Aquí se implementaría el código para escanear el PDF417
      // usando la biblioteca mobile_scanner y pdf417

      // Simulamos una lectura exitosa para el propósito de este código
      // En una implementación real, este string vendría de la lectura del PDF417
      final rawData = '''@
APELLIDO
NOMBRE
M
12345678
ARGENTINA
19900101
20200101
20300101
00
12345678901234''';

      return DNIModel.fromPdf417String(rawData);
    } catch (e) {
      throw ScanException('Error al escanear DNI: ${e.toString()}');
    }
  }
}