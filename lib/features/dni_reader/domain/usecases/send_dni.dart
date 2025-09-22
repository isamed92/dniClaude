import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/dni_repository.dart';

class SendDNI implements UseCase<bool, SendDNIParams> {
  final DNIRepository repository;

  SendDNI(this.repository);

  @override
  Future<Either<Failure, bool>> call(SendDNIParams params) async {
    return await repository.sendDNI(params.dni);
  }
}

class SendDNIParams extends Equatable {
  final String dni;

  const SendDNIParams({required this.dni});

  @override
  List<Object> get props => [dni];
}