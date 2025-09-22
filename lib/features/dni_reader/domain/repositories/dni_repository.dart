import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dni.dart';

abstract class DNIRepository {
  /// Escanea un código PDF417 y devuelve los datos del DNI parseados
  Future<Either<Failure, DNI>> scanDNI();

  /// Envía el DNI escaneado al servidor
  Future<Either<Failure, bool>> sendDNI(String dni);
}