import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP FINANCIERA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF40E0D0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'APP FINANCIERA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _showLogoutButton = false;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleLogoutButton() {
    setState(() {
      _showLogoutButton = !_showLogoutButton;
    });
  }

  void _logout() {
    // Lógica para cerrar sesión
    debugPrint('Usuario salió de la aplicación');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF40E0D0),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          // Barra de bienvenida con el botón de usuario
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Bienvenid@ Usuario',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  children: [
                    if (_showLogoutButton)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: _logout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          ),
                          child: const Text('Salir'),
                        ),
                      ),
                    GestureDetector(
                      onTap: _toggleLogoutButton,
                      child: const Icon(
                        Icons.account_circle,
                        size: 30,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Espacio entre el mensaje y el saldo
          const SizedBox(height: 25),
          // Saldo centrado
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '\$0.00',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF40E0D0),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tu dinero',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          // Espacio restante
          const Expanded(child: SizedBox()),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: const Color(0xFF40E0D0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, size: 28, color: Colors.white),
              onPressed: () => _onTabTapped(0),
              tooltip: 'Inicio',
            ),
            IconButton(
              icon: const Icon(Icons.history, size: 28, color: Colors.white),
              onPressed: () => _onTabTapped(1),
              tooltip: 'Historial',
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart, size: 28, color: Colors.white),
              onPressed: () => _onTabTapped(2),
              tooltip: 'Gráficos',
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today, size: 28, color: Colors.white),
              onPressed: () => _onTabTapped(3),
              tooltip: 'Calendario',
            ),
            IconButton(
              icon: const Icon(Icons.settings, size: 28, color: Colors.white),
              onPressed: () => _onTabTapped(4),
              tooltip: 'Ajustes',
            ),
          ],
        ),
      ),
    );
  }
}