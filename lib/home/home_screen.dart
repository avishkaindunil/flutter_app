import 'package:flutter/material.dart';
import 'home_grid.dart';
import '../calculator/calculator_page.dart';
import '../converter/currency_converter_page.dart';
import '../takephoto/take_photo.dart';
import 'package:camera/camera.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final List<CameraDescription> cameras;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.cameras,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    const HomeGrid(),
    const CalculatorPage(),
    const CurrencyConverterPage(),
    TakePhotoPage(cameras: widget.cameras),
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
            return HomeGrid(
              onTapCalculator: () => _onSelect(1),
              onTapConverter: () => _onSelect(2),
              onTapTakePhoto: () => _onSelect(3),
            );
          }
          return page;
        }).toList(),
      ),
    );
  }
}