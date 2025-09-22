import '../../domain/entities/dni.dart';

class DNIModel extends DNI {
  const DNIModel({
    required super.numero,
    required super.apellido,
    required super.nombre,
    required super.sexo,
    required super.fechaNacimiento,
    required super.fechaEmision,
    required super.fechaVencimiento,
    required super.ejemplar,
    required super.tramite,
  });

  factory DNIModel.fromPdf417String(String rawData) {
    // Los datos del PDF417 del DNI argentino vienen en formato:
    // @\n
    // APELLIDO\n
    // NOMBRE\n
    // SEXO\n
    // DNI\n
    // NACIONALIDAD\n
    // FECHA_NACIMIENTO\n
    // FECHA_EMISION\n
    // FECHA_VENCIMIENTO\n
    // EJEMPLAR\n
    // TRAMITE\n
    // etc...

    final lines = rawData.split('\n');

    // Verificamos que tengamos suficientes datos para mapear
    if (lines.length < 11) {
      throw FormatException('Formato de PDF417 inválido para DNI argentino');
    }

    return DNIModel(
      apellido: lines[1].trim(),
      nombre: lines[2].trim(),
      sexo: lines[3].trim(),
      numero: lines[4].trim(),
      fechaNacimiento: _formatearFecha(lines[6].trim()),
      fechaEmision: _formatearFecha(lines[7].trim()),
      fechaVencimiento: _formatearFecha(lines[8].trim()),
      ejemplar: lines[9].trim(),
      tramite: lines[10].trim(),
    );
  }

  static String _formatearFecha(String fecha) {
    // Las fechas en el DNI vienen en formato AAAAMMDD
    if (fecha.length != 8) return fecha;

    try {
      final anio = fecha.substring(0, 4);
      final mes = fecha.substring(4, 6);
      final dia = fecha.substring(6, 8);

      return '$dia/$mes/$anio';
    } catch (e) {
      return fecha;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'dni': numero,
      'apellido': apellido,
      'nombre': nombre,
      'sexo': sexo,
      'fechaNacimiento': fechaNacimiento,
      'fechaEmision': fechaEmision,
      'fechaVencimiento': fechaVencimiento,
      'ejemplar': ejemplar,
      'tramite': tramite,
    };
  }
}