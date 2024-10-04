import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
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
  String _displayText = '';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String? _operator;

  void _onNumberPressed(String number) {
    setState(() {
      _displayText += number; // Append the number to the display
    });
  }

  void _onOperatorPressed(String operator) {
    _firstOperand = double.parse(_displayText);
    _operator = operator;
    setState(() {
      _displayText = '';
    });
  }

  void _onEqualPressed() {
    _secondOperand = double.parse(_displayText); // Get the second operand

    double result;
    switch (_operator) {
      case '+':
        result = _firstOperand + _secondOperand;
        break;
      case '-':
        result = _firstOperand - _secondOperand;
        break;
      case '*':
        result = _firstOperand * _secondOperand;
        break;
      case '/':
        result = _firstOperand / _secondOperand;
        break;
      case '%':
        result = _firstOperand % _secondOperand;
        break;
      default:
        result = 0;
        break;
    }

    setState(() {
      if (result == result.toInt()) {
        _displayText = result
            .toInt()
            .toString(); // Display as integer if it has no decimals
      } else {
        _displayText = result
            .toString(); // Display as floating point if it is not a whole number
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _displayText = '';
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = null;
    });
  }

  void _onDecimalPressed() {
    if (!_displayText.contains('.')) {
      setState(() {
        _displayText += '.';
      });
    }
  }

  void _onToggleSignPressed() {
    if (_displayText.isNotEmpty) {
      setState(() {
        if (_displayText.contains('.')) {
          double currentNumber = double.parse(_displayText);
          _displayText =
              (-currentNumber).toString(); // Keep decimal if it already exists
        } else {
          int currentNumber = int.parse(_displayText);
          _displayText = (-currentNumber)
              .toString(); // Does not add '.0' if it does not have a decimal yet.
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _displayText.isEmpty ? '0' : _displayText, // Display text or 0
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _onClearPressed, child: const Text('AC')),
                ElevatedButton(
                    onPressed: _onToggleSignPressed, child: Text('+/-')),
                ElevatedButton(
                    onPressed: () => _onOperatorPressed('%'), child: Text('%')),
                ElevatedButton(
                    onPressed: () => _onOperatorPressed('/'),
                    child: const Text('/')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => _onNumberPressed('7'),
                    child: const Text('7')),
                ElevatedButton(
                    onPressed: () => _onNumberPressed('8'),
                    child: const Text('8')),
                ElevatedButton(
                    onPressed: () => _onNumberPressed('9'),
                    child: const Text('9')),
                ElevatedButton(
                    onPressed: () => _onOperatorPressed('*'),
                    child: const Text('*')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => _onNumberPressed('4'),
                    child: const Text('4')),
                ElevatedButton(
                    onPressed: () => _onNumberPressed('5'),
                    child: const Text('5')),
                ElevatedButton(
                    onPressed: () => _onNumberPressed('6'),
                    child: const Text('6')),
                ElevatedButton(
                    onPressed: () => _onOperatorPressed('-'),
                    child: const Text('-')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => _onNumberPressed('1'),
                    child: const Text('1')),
                ElevatedButton(
                    onPressed: () => _onNumberPressed('2'),
                    child: const Text('2')),
                ElevatedButton(
                    onPressed: () => _onNumberPressed('3'),
                    child: const Text('3')),
                ElevatedButton(
                    onPressed: () => _onOperatorPressed('+'),
                    child: const Text('+')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => _onNumberPressed('0'),
                    child: const Text('0')),
                ElevatedButton(
                    onPressed: () => _onDecimalPressed(),
                    child: const Text('.')),
                ElevatedButton(
                    onPressed: _onEqualPressed, child: const Text('=')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
