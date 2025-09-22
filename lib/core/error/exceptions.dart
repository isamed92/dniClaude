class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Error de servidor']);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Error de caché']);
}

class ScanException implements Exception {
  final String message;
  ScanException([this.message = 'Error al escanear']);
}