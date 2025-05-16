import 'package:flutter/material.dart';
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
  double _ingresosTotales = 0.00;
  double _gastosTotales = 0.00;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToIngresos() async {
    final result = await Navigator.pushNamed(context, '/ingresos');
    if (result != null && result is double) {
      _actualizarSaldo(result);
    }
  }

  void _navigateToGastos() async {
    final result = await Navigator.pushNamed(context, '/gastos');
    if (result != null && result is double) {
      _actualizarSaldo(-result);
    }
  }

  void _actualizarSaldo(double cantidad) {
    setState(() {
      _saldo += cantidad;
      if (cantidad > 0) {
        _ingresosTotales += cantidad;
      } else {
        _gastosTotales += cantidad.abs();
      }
    });
  }

  List<Widget> _buildScreens() {
    return [
      _HomeContent(), // reconstruido con datos nuevos
      const HistorialScreen(),
      const GraficosScreen(),
      const CalendarioScreen(),
    ];
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
        children: _buildScreens(),
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

class _HomeContent extends StatelessWidget {
  _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_MyHomePageState>();
    final username = state?.widget.username ?? 'Usuario';
    final saldo = state?._saldo ?? 0.00;
    final ingresos = state?._ingresosTotales ?? 0.00;
    final gastos = state?._gastosTotales ?? 0.00;
    final diferencia = ingresos - gastos;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Barra de bienvenida
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bienvenid@ $username',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.account_circle),
                        color: Colors.black87,
                        onPressed: () {},
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
                    '\$${saldo.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: saldo >= 0 ? const Color(0xFF40E0D0) : Colors.red,
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
                    onPressed: state?._navigateToIngresos,
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
                    onPressed: state?._navigateToGastos,
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
                      'Resumen financiero',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ingresos', style: TextStyle(color: Colors.black87, fontSize: 18)),
                        Text('\$${ingresos.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black54, fontSize: 16)),
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
                      children: [
                        const Text('Gastos', style: TextStyle(color: Colors.black87, fontSize: 18)),
                        Text('\$${gastos.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black54, fontSize: 16)),
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
                      children: [
                        Icon(
                          diferencia >= 0 ? Icons.check_circle : Icons.warning_amber_rounded,
                          color: diferencia >= 0 ? Colors.green : Colors.red,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Restante: \$${diferencia.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: diferencia >= 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      diferencia >= 0
                          ? 'Tienes un saldo positivo de \$${diferencia.toStringAsFixed(2)}'
                          : 'Has gastado \$${diferencia.abs().toStringAsFixed(2)} más que tus ingresos',
                      style: TextStyle(
                        color: diferencia >= 0 ? Colors.green : Colors.red,
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
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: BarChartIngresosGastos(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}