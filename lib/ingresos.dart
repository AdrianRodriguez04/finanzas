import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IngresosScreen extends StatefulWidget {
  const IngresosScreen({super.key});

  @override
  State<IngresosScreen> createState() => _IngresosScreenState();
}

class _IngresosScreenState extends State<IngresosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _fuenteController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  @override
  void dispose() {
    _montoController.dispose();
    _nombreController.dispose();
    _fuenteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF40E0D0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Registrar Ingreso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _montoController,
                decoration: const InputDecoration(
                  labelText: 'Monto del Ingreso',
                  icon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Ingreso',
                  icon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre del ingreso';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _fuenteController,
                decoration: const InputDecoration(
                  labelText: 'Fuente',
                  icon: Icon(Icons.source),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la fuente';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        border: const OutlineInputBorder(),
                        hintText: _selectedDate == null
                            ? 'Selecciona una fecha'
                            : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validator: (value) {
                        if (_selectedDate == null) {
                          return 'Por favor, selecciona una fecha';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () => _selectDate(context),
                    tooltip: 'Seleccionar fecha',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final monto = double.parse(_montoController.text);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ingreso registrado')),
                    );

                    // Retornar el monto a la pantalla anterior
                    Navigator.pop(context, monto);

                    // Limpiar el formulario
                    _formKey.currentState!.reset();
                    _montoController.clear();
                    _nombreController.clear();
                    _fuenteController.clear();
                    setState(() {
                      _selectedDate = DateTime.now();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF40E0D0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Registrar Ingreso'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}