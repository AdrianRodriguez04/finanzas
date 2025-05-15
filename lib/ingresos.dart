import 'package:flutter/material.dart';

class IngresosScreen extends StatelessWidget {
  const IngresosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF40E0D0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Ingresos'),
      ),
      body: const Center(
        child: Text('Pantalla de Ingresos'),
      ),
    );
  }
}