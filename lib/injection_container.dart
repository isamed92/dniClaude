import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/dni_reader/data/datasources/dni_local_datasource.dart';
import 'features/dni_reader/data/datasources/dni_remote_datasource.dart';
import 'features/dni_reader/data/datasources/dni_scanner_impl.dart';
import 'features/dni_reader/data/repositories/dni_repository_impl.dart';
import 'features/dni_reader/domain/repositories/dni_repository.dart';
import 'features/dni_reader/domain/usecases/scan_dni.dart';
import 'features/dni_reader/domain/usecases/send_dni.dart';
import 'features/dni_reader/presentation/bloc/dni_reader_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - DNI Reader
  // Bloc
  sl.registerFactory(
    () => DNIReaderBloc(
      scanDNI: sl(),
      sendDNI: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => ScanDNI(sl()));
  sl.registerLazySingleton(() => SendDNI(sl()));

  // Repository
  sl.registerLazySingleton<DNIRepository>(
    () => DNIRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<DNIRemoteDataSource>(
    () => DNIRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<DNILocalDataSource>(
    () => DNIScannerImpl(scannerController: sl()),
  );

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => MobileScannerController(
    facing: CameraFacing.back,
    formats: [BarcodeFormat.pdf417],
  ));
}