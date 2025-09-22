import 'package:equatable/equatable.dart';

abstract class DNIReaderEvent extends Equatable {
  const DNIReaderEvent();

  @override
  List<Object> get props => [];
}

class ScanDNIEvent extends DNIReaderEvent {}

class SendDNIEvent extends DNIReaderEvent {
  final String dni;

  const SendDNIEvent({required this.dni});

  @override
  List<Object> get props => [dni];
}

class ResetScannerEvent extends DNIReaderEvent {}