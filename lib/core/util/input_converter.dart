import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class InputConverter {
  Either<Failure, String> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(str);
    } on FormatException {
      return Left(ScanFailure('El DNI debe ser un número'));
    }
  }
}