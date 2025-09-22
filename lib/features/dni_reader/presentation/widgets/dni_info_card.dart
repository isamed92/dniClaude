import 'package:flutter/material.dart';

import '../../domain/entities/dni.dart';

class DNIInfoCard extends StatelessWidget {
  final DNI dni;

  const DNIInfoCard({super.key, required this.dni});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'DNI: ${dni.numero}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoRow('Apellido', dni.apellido),
            _buildInfoRow('Nombre', dni.nombre),
            _buildInfoRow('Sexo', dni.sexo),
            _buildInfoRow('Fecha de nacimiento', dni.fechaNacimiento),
            _buildInfoRow('Fecha de emisión', dni.fechaEmision),
            _buildInfoRow('Fecha de vencimiento', dni.fechaVencimiento),
            _buildInfoRow('Ejemplar', dni.ejemplar),
            _buildInfoRow('Trámite', dni.tramite),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'La información se enviará al servidor para su procesamiento',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}