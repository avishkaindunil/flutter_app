import 'package:flutter/material.dart';
import '../common/calculator_button.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _display = '0';
  bool _shouldClear = false;
  static const List<String> _buttons = [
    'C', '+/-', '%', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', '=', ''
  ];

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _display = '0';
        _shouldClear = false;
      } else if (value == '+/-') {
        _display = _display.startsWith('-') ? _display.substring(1) : '-$_display';
      } else if (value == '%') {
        final val = double.tryParse(_display) ?? 0;
        _display = (val / 100).toString();
      } else if (_isOperator(value)) {
        if (_expression.isNotEmpty && !_shouldClear) {
          _chainCalculation(value);
        } else if (_expression.isEmpty) {
          _expression = _display;
        }
        _expression += ' $value ';
        _display = '';
        _shouldClear = true;
      } else if (value == '=') {
        _calculateResult();
      } else {
        if (_shouldClear) {
          _display = '';
          _shouldClear = false;
        }
        if (value == '.' && _display.contains('.')) return;
        _display = (_display == '0' && value != '.') ? value : '$_display$value';
      }
    });
  }

  bool _isOperator(String v) => ['÷', '×', '-', '+'].contains(v);

  void _chainCalculation(String nextOp) {
    final parts = _expression.split(' ');
    final a = double.tryParse(parts[0]) ?? 0;
    final op = parts[1];
    final b = double.tryParse(_display) ?? 0;
    final result = _compute(a, b, op);
    _expression = result.toString();
  }

  void _calculateResult() {
    if (_expression.isEmpty) return;
    final parts = _expression.split(' ');
    final a = double.tryParse(parts[0]) ?? 0;
    final op = parts[1];
    final b = double.tryParse(_display) ?? 0;
    final result = _compute(a, b, op);
    _display = result.toString();
    _expression = '';
    _shouldClear = true;
  }

  double _compute(double a, double b, String op) {
    switch (op) {
      case '+': return a + b;
      case '-': return a - b;
      case '×': return a * b;
      case '÷': return b != 0 ? a / b : 0;
      default: return b;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Theme.of(context).textTheme.bodySmall!.color,
            tabs: const [Tab(text: 'Normal'), Tab(text: 'Scientific'), Tab(text: 'Programming')],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildNormalMode(context),
                Center(child: Text('Scientific mode pending', style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color))),
                Center(child: Text('Programming mode pending', style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalMode(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(24),
            child: Text('$_expression$_display', style: TextStyle(fontSize: 48, color: Theme.of(context).textTheme.bodyLarge!.color)),
          ),
        ),
        Expanded(
          flex: 5,
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemCount: _buttons.length,
            itemBuilder: (_, i) {
              final lbl = _buttons[i]; if (lbl.isEmpty) return const SizedBox.shrink();
              final isOp = ['÷','×','-','+','=','%','+/-'].contains(lbl);
              final bg = isOp ? Colors.orange : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[800]! : Colors.grey[300]!);
              final fg = isOp ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
              return CalculatorButton(label: lbl, color: bg, textColor: fg, onTap: () => _onButtonPressed(lbl));
            },
          ),
        ),
      ],
    );
  }
}
