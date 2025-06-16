import 'package:flutter/material.dart';
import 'home_grid.dart';
import '../calculator/calculator_page.dart';
import '../converter/currency_converter_page.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeGrid(),
    const CalculatorPage(),
    const CurrencyConverterPage(),
  ];

  void _onSelect(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: _currentIndex == 0
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _onSelect(0),
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.map((page) {
          if (page is HomeGrid) {
            return HomeGrid(onTapCalculator: () => _onSelect(1));
          }
          return page;
        }).toList(),
      ),
    );
  }
}