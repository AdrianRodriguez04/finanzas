import 'package:flutter/material.dart';
import 'historial.dart';
import 'graficos.dart';
import 'calendario.dart';
import 'gastos.dart';
import 'ingresos.dart';

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
      routes: {
        '/historial': (context) => const HistorialScreen(),
        '/graficos': (context) => const GraficosScreen(),
        '/calendario': (context) => const CalendarioScreen(),
        '/gastos': (context) => const GastosScreen(),
        '/ingresos': (context) => const IngresosScreen(),
      },
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
  double _saldo = 0.00;

  // Lista de pantallas
  final List<Widget> _screens = [
    const _HomeContent(), // Contenido principal de la pantalla de inicio
    const HistorialScreen(),
    const GraficosScreen(),
    const CalendarioScreen(),
  ];

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
    debugPrint('Usuario salió de la aplicación');
  }

  void _navigateToIngresos() {
    Navigator.pushNamed(context, '/ingresos');
  }

  void _navigateToGastos() {
    Navigator.pushNamed(context, '/gastos');
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
      // Usamos IndexedStack para mantener el estado de cada pantalla
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: const Color(0xFF40E0D0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home,
                  color: _currentIndex == 0 ? Colors.white : Colors.white70),
              onPressed: () => _onTabTapped(0),
              tooltip: 'Inicio',
            ),
            IconButton(
              icon: Icon(Icons.history,
                  color: _currentIndex == 1 ? Colors.white : Colors.white70),
              onPressed: () => _onTabTapped(1),
              tooltip: 'Historial',
            ),
            IconButton(
              icon: Icon(Icons.bar_chart,
                  color: _currentIndex == 2 ? Colors.white : Colors.white70),
              onPressed: () => _onTabTapped(2),
              tooltip: 'Gráficos',
            ),
            IconButton(
              icon: Icon(Icons.calendar_today,
                  color: _currentIndex == 3 ? Colors.white : Colors.white70),
              onPressed: () => _onTabTapped(3),
              tooltip: 'Calendario',
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para el contenido de la pantalla de inicio
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_MyHomePageState>()!;

    return Column(
      children: [
        // Barra de bienvenida
        Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bienvenid@ Usuario',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  if (state._showLogoutButton)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        onPressed: state._logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Salir'),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.account_circle),
                    color: Colors.black87,
                    onPressed: state._toggleLogoutButton,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Saldo
        Column(
          children: [
            Text(
              '\$${state._saldo.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF40E0D0),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tu dinero',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: state._navigateToIngresos,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7FFFD4),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Ingresos'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: state._navigateToGastos,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008B8B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Gastos'),
                ),
              ],
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}