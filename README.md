# Módulo de Lectura de DNI Argentino

Este proyecto implementa un módulo en Flutter para escanear códigos PDF417 de DNI argentinos utilizando Clean Architecture y BLoC para la gestión de estado.

## Características

- Escaneo de códigos PDF417 de DNI argentino
- Mapeo de datos del DNI (nombre, apellido, número, etc.)
- Envío del DNI a un endpoint para su procesamiento
- Interfaz de usuario intuitiva con feedback para el usuario
- Implementación de Clean Architecture
- Gestión de estado con BLoC

## Estructura del Proyecto

El proyecto sigue los principios de Clean Architecture con la siguiente estructura:

```
lib/
├── core/
│   ├── error/
│   ├── network/
│   ├── usecases/
│   └── util/
├── features/
│   └── dni_reader/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
└── main.dart
```

## Requisitos

- Flutter 3.0.0 o superior
- Cámara trasera para escaneo de códigos
- Conexión a Internet para enviar datos al servidor

## Dependencias

- `equatable` para comparación de objetos
- `dartz` para programación funcional
- `get_it` para inyección de dependencias
- `flutter_bloc` para gestión de estado
- `mobile_scanner` para escaneo de códigos de barras
- `pdf417` para decodificación de códigos PDF417
- `http` para comunicación con el servidor