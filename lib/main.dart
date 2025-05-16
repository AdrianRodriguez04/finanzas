import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fl_chart/fl_chart.dart';
import 'login.dart';
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
      home: const LoginScreen(),
      routes: {
        '/home': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return MyHomePage(
            title: 'APP FINANCIERA',
            username: args?['username'] ?? 'Usuario',
          );
        },
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
  final String title;
  final String username;

  const MyHomePage({
    super.key,
    required this.title,
    required this.username,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  double _saldo = 0.00;

  // Lista de pantallas
  final List<Widget> _screens = [
    _HomeContent(), // Ahora recibe el username
    const HistorialScreen(),
    const GraficosScreen(),
    const CalendarioScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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

class _HomeContent extends StatefulWidget {
  _HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  bool _showLogoutButton = false;
  double _saldo = 0.00;

  void _toggleLogoutButton() {
    setState(() {
      _showLogoutButton = !_showLogoutButton;
    });
  }

  void _logout() {
    // Cierra la aplicación completamente
    Future.delayed(Duration.zero, () {
      SystemNavigator.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_MyHomePageState>();
    final username = (parentState?.widget as MyHomePage).username;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Barra de bienvenida con nombre de usuario
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bienvenid@ $username',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                            ),
                            child: const Text('Salir'),
                          ),
                        ),
                      IconButton(
                        icon: const Icon(Icons.account_circle),
                        color: Colors.black87,
                        onPressed: _toggleLogoutButton,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Saldo
              Column(
                children: [
                  Text(
                    '\$${_saldo.toStringAsFixed(2)}',
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
                ],
              ),

              const SizedBox(height: 30),

              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: parentState?._navigateToIngresos,
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
                    onPressed: parentState?._navigateToGastos,
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

              const SizedBox(height: 30),
              // Barra de estado financiera
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '26 abr 2025 - 25 may 2025',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Ingresos', style: TextStyle(color: Colors.black87, fontSize: 18)),
                        Text('\$ 0.00', style: TextStyle(color: Colors.black54, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Gastos', style: TextStyle(color: Colors.black87, fontSize: 18)),
                        Text('\$ 0.00', style: TextStyle(color: Colors.black54, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Icon(Icons.warning_amber_rounded, color: Colors.red, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Restante:  \$ 0.00',
                          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Has gastado \$ 0.00 más respecto a tus ingresos',
                      style: TextStyle(color: Colors.black38),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Ingresos y gastos mensuales',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,

                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: BarChartIngresosGastos(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}