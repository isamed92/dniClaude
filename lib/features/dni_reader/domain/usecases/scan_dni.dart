import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dni.dart';
import '../repositories/dni_repository.dart';

class ScanDNI implements UseCase<DNI, NoParams> {
  final DNIRepository repository;

  ScanDNI(this.repository);

  @override
  Future<Either<Failure, DNI>> call(NoParams params) async {
    return await repository.scanDNI();
  }
}