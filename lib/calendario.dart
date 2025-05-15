import 'package:flutter/material.dart';

class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Esta es la ventana de Calendario',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}