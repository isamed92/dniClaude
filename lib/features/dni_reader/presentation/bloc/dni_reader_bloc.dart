import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/scan_dni.dart';
import '../../domain/usecases/send_dni.dart';
import 'dni_reader_event.dart';
import 'dni_reader_state.dart';

class DNIReaderBloc extends Bloc<DNIReaderEvent, DNIReaderState> {
  final ScanDNI scanDNI;
  final SendDNI sendDNI;

  DNIReaderBloc({
    required this.scanDNI,
    required this.sendDNI,
  }) : super(Empty()) {
    on<ScanDNIEvent>(_onScanDNI);
    on<SendDNIEvent>(_onSendDNI);
    on<ResetScannerEvent>(_onResetScanner);
  }

  Future<void> _onScanDNI(ScanDNIEvent event, Emitter<DNIReaderState> emit) async {
    emit(Loading());
    final failureOrDNI = await scanDNI(NoParams());

    emit(failureOrDNI.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (dni) => ScanSuccess(dni: dni),
    ));
  }

  Future<void> _onSendDNI(SendDNIEvent event, Emitter<DNIReaderState> emit) async {
    emit(Loading());
    final failureOrSuccess = await sendDNI(SendDNIParams(dni: event.dni));

    emit(failureOrSuccess.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (success) => SendSuccess(),
    ));
  }

  void _onResetScanner(ResetScannerEvent event, Emitter<DNIReaderState> emit) {
    emit(Empty());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Error de servidor al procesar la solicitud';
      case ScanFailure:
        return (failure as ScanFailure).message;
      default:
        return 'Error inesperado';
    }
  }
}