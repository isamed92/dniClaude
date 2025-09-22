import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/dni.dart';
import '../../domain/repositories/dni_repository.dart';
import '../datasources/dni_local_datasource.dart';
import '../datasources/dni_remote_datasource.dart';

class DNIRepositoryImpl implements DNIRepository {
  final DNIRemoteDataSource remoteDataSource;
  final DNILocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DNIRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DNI>> scanDNI() async {
    try {
      final dniModel = await localDataSource.scanDNI();
      return Right(dniModel);
    } on ScanException catch (e) {
      return Left(ScanFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> sendDNI(String dni) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.sendDNI(dni);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}