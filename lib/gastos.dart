import 'package:flutter/material.dart';

class GastosScreen extends StatelessWidget {
  const GastosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF008B8B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Gastos'),
      ),
      body: const Center(
        child: Text('Pantalla de Gastos'),
      ),
    );
  }
}