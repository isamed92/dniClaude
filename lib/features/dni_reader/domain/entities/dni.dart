import 'package:equatable/equatable.dart';

class DNI extends Equatable {
  final String numero;
  final String apellido;
  final String nombre;
  final String sexo;
  final String fechaNacimiento;
  final String fechaEmision;
  final String fechaVencimiento;
  final String ejemplar;
  final String tramite;

  const DNI({
    required this.numero,
    required this.apellido,
    required this.nombre,
    required this.sexo,
    required this.fechaNacimiento,
    required this.fechaEmision,
    required this.fechaVencimiento,
    required this.ejemplar,
    required this.tramite,
  });

  @override
  List<Object> get props => [
        numero,
        apellido,
        nombre,
        sexo,
        fechaNacimiento,
        fechaEmision,
        fechaVencimiento,
        ejemplar,
        tramite,
      ];
}