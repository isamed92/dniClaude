import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../bloc/dni_reader_bloc.dart';
import '../bloc/dni_reader_event.dart';
import '../bloc/dni_reader_state.dart';
import '../widgets/dni_info_card.dart';

class DNIScannerPage extends StatefulWidget {
  const DNIScannerPage({super.key});

  @override
  State<DNIScannerPage> createState() => _DNIScannerPageState();
}

class _DNIScannerPageState extends State<DNIScannerPage> {
  late MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      facing: CameraFacing.back,
      formats: [BarcodeFormat.pdf417],
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escáner de DNI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<DNIReaderBloc>().add(ResetScannerEvent());
            },
          ),
        ],
      ),
      body: BlocConsumer<DNIReaderBloc, DNIReaderState>(
        listener: (context, state) {
          if (state is Error) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
            );
          } else if (state is SendSuccess) {
            Fluttertoast.showToast(
              msg: 'DNI enviado correctamente',
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
            );
          }
        },
        builder: (context, state) {
          if (state is Empty) {
            return _buildScannerView();
          } else if (state is Loading) {
            return _buildLoadingView();
          } else if (state is ScanSuccess) {
            return _buildSuccessView(state);
          } else if (state is SendSuccess) {
            return _buildCompletedView();
          } else if (state is Error) {
            return _buildErrorView(state);
          } else {
            return _buildScannerView();
          }
        },
      ),
    );
  }

  Widget _buildScannerView() {
    return Column(
      children: [
        Expanded(
          child: MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              // No hacemos nada aquí porque la detección se maneja en el BLoC
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              context.read<DNIReaderBloc>().add(ScanDNIEvent());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('INICIAR ESCANEO'),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitCircle(
            color: Colors.blue,
            size: 50.0,
          ),
          SizedBox(height: 20),
          Text('Procesando...'),
        ],
      ),
    );
  }

  Widget _buildSuccessView(ScanSuccess state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DNIInfoCard(dni: state.dni),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DNIReaderBloc>().add(SendDNIEvent(dni: state.dni.numero));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.green,
            ),
            child: const Text('ENVIAR DNI'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              context.read<DNIReaderBloc>().add(ResetScannerEvent());
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('VOLVER A ESCANEAR'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(Error state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          SizedBox(height: 20),
          Text(
            state.message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              context.read<DNIReaderBloc>().add(ResetScannerEvent());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('REINTENTAR'),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 100,
          ),
          SizedBox(height: 20),
          Text(
            'DNI enviado correctamente',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              context.read<DNIReaderBloc>().add(ResetScannerEvent());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('ESCANEAR OTRO DNI'),
          ),
        ],
      ),
    );
  }
}