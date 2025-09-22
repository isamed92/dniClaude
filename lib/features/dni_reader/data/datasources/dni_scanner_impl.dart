import 'dart:async';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/error/exceptions.dart';
import '../models/dni_model.dart';
import 'dni_local_datasource.dart';

class DNIScannerImpl implements DNILocalDataSource {
  final MobileScannerController scannerController;

  DNIScannerImpl({required this.scannerController});

  @override
  Future<DNIModel> scanDNI() {
    final completer = Completer<DNIModel>();

    // Escuchar los resultados del escaneo
    scannerController.barcodes.listen(
      (barcode) {
        if (barcode.rawValue != null && !completer.isCompleted) {
          try {
            final rawData = barcode.rawValue!;

            // Verificar si es un código PDF417 de DNI argentino
            if (rawData.startsWith('@')) {
              final dniModel = DNIModel.fromPdf417String(rawData);
              completer.complete(dniModel);
              scannerController.stop();
            }
          } catch (e) {
            if (!completer.isCompleted) {
              completer.completeError(ScanException('Error al procesar el código: ${e.toString()}'));
            }
          }
        }
      },
      onError: (error) {
        if (!completer.isCompleted) {
          completer.completeError(ScanException('Error al escanear: ${error.toString()}'));
        }
      },
      cancelOnError: false,
    );

    // Iniciar el escaneo
    scannerController.start();

    // Timeout después de 60 segundos si no se ha escaneado nada
    Timer(const Duration(seconds: 60), () {
      if (!completer.isCompleted) {
        scannerController.stop();
        completer.completeError(ScanException('Tiempo de espera agotado'));
      }
    });

    return completer.future;
  }
}