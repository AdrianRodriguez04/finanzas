import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de que este paquete esté en tu pubspec.yaml

class GastosScreen extends StatefulWidget {
  const GastosScreen({super.key});

  @override
  State<GastosScreen> createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> {
  // Variables para los campos del formulario
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _vendedorController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  @override
  void dispose() {
    // Limpia los controladores cuando el widget se descarta
    _montoController.dispose();
    _nombreController.dispose();
    _vendedorController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Da valores iniciales al formulario
    super.initState();
    _selectedDate = DateTime.now();
    // _montoController.text = '50';
  }

  // Función para mostrar el selector de fecha
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
        title: const Text('Registrar Gasto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Campo para el Monto del Gasto
              TextFormField(
                controller: _montoController,
                decoration: const InputDecoration(
                  labelText: 'Monto del Gasto',
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

              // Campo para el Nombre del Gasto
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Gasto',
                  icon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre del gasto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo para el Vendedor
              TextFormField(
                controller: _vendedorController,
                decoration: const InputDecoration(
                  labelText: 'Vendedor',
                  icon: Icon(Icons.store),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el vendedor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo para la Fecha
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

              // Botón para Registrar el Gasto
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gasto registrado')),
                    );
                    // Lógica para guardar el gasto:
                    print('Monto: ${_montoController.text}');
                    print('Nombre: ${_nombreController.text}');
                    print('Vendedor: ${_vendedorController.text}');
                    if (_selectedDate != null) {
                      print('Fecha: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}');
                    }


                    // Opcional: Limpiar el formulario
                    _formKey.currentState!.reset();
                    _montoController.clear();
                    _nombreController.clear();
                    _vendedorController.clear();
                    setState(() {
                      _selectedDate = null;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF40E0D0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Registrar Gasto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}