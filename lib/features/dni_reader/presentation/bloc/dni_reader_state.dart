import 'package:equatable/equatable.dart';

import '../../domain/entities/dni.dart';

abstract class DNIReaderState extends Equatable {
  const DNIReaderState();

  @override
  List<Object> get props => [];
}

class Empty extends DNIReaderState {}

class Loading extends DNIReaderState {}

class ScanSuccess extends DNIReaderState {
  final DNI dni;

  const ScanSuccess({required this.dni});

  @override
  List<Object> get props => [dni];
}

class SendSuccess extends DNIReaderState {}

class Error extends DNIReaderState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}