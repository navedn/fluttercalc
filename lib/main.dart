import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

///Todo: If the equals symbol is pressed repeatedly without changing anything how does it change the displayed number?

ThemeData myTheme() {
  return ThemeData(
    colorScheme: ColorScheme(
      primary: Color.fromRGBO(251, 111, 146, 1), // Main App Bar Color
      secondary: Color.fromRGBO(255, 143, 171, 1), // Accent/Highlight color
      background: Color.fromRGBO(255, 229, 236, 1), // Background color
      surface: Color.fromRGBO(255, 179, 198, 1), // Button color
      error: Colors.red,
      onPrimary: Colors.black, // Text color on primary
      onSecondary: Colors.black, // Text color on secondary
      onBackground: Colors.black, // Text color on background
      onSurface: Colors.black, // Text color on surface
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Color.fromRGBO(255, 229, 236, 1),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: 24), // Larger button text
        padding: EdgeInsets.symmetric(
            vertical: 15, horizontal: 25), // Larger button padding
        backgroundColor:
            Color.fromRGBO(255, 179, 198, 1), // Default button background
      ),
    ),
    textTheme: TextTheme(
      headlineMedium:
          TextStyle(fontSize: 36, color: Colors.black), // Larger display text
      bodyMedium: TextStyle(fontSize: 24), // Larger text in general
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(251, 111, 146, 1),
      titleTextStyle: TextStyle(fontSize: 24, color: Colors.black),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: myTheme(),
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
      if (_displayText.isEmpty && _operator != null) {
        _displayText = number;
      } else {
        _displayText += number;
      }
    });
  }

  void _onOperatorPressed(String operator) {
    if (_displayText.isNotEmpty) {
      _firstOperand = double.parse(_displayText);
    }
    _operator = operator;
    setState(() {
      _displayText = '';
    });
  }

  void _onEqualPressed() {
    if (_operator != null && _displayText.isNotEmpty) {
      if (_secondOperand == 0) {
        _secondOperand = double.parse(_displayText);
      }

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
          if (_secondOperand == 0) {
            setState(() {
              _displayText =
                  'Undefined: Div by Zero'; // Handle division by zero
            });
            return;
          }
          result = _firstOperand / _secondOperand;
          break;
        case '%':
          result = _firstOperand % _secondOperand;
          break;
        default:
          result = 0;
          break;
      }

      // Update display with the result
      setState(() {
        // Update display with result
        _displayText =
            result.toStringAsFixed(10).replaceFirst(RegExp(r'\.?0+$'), '');
        _firstOperand = result;
        _secondOperand = 0;
        _operator = null;
      });
    }
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
        backgroundColor: Color.fromRGBO(251, 111, 146, 1),
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
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(204, 86, 116, 0.8)),
                    onPressed: _onClearPressed,
                    child: const Text(
                      'AC',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(204, 86, 116, 0.8)),
                    onPressed: _onToggleSignPressed,
                    child: Text(
                      '+/-',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(204, 86, 116, 0.8)),
                    onPressed: () => _onOperatorPressed('%'),
                    child: Text(
                      '%',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 143, 171, 1)),
                    onPressed: () => _onOperatorPressed('/'),
                    child: const Text(
                      '/',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('7'),
                    child: const Text(
                      '7',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('8'),
                    child: const Text(
                      '8',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('9'),
                    child: const Text(
                      '9',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 143, 171, 1)),
                    onPressed: () => _onOperatorPressed('*'),
                    child: const Text(
                      '*',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('4'),
                    child: const Text(
                      '4',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('5'),
                    child: const Text(
                      '5',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('6'),
                    child: const Text(
                      '6',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 143, 171, 1)),
                    onPressed: () => _onOperatorPressed('-'),
                    child: const Text(
                      '-',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('1'),
                    child: const Text(
                      '1',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('2'),
                    child: const Text(
                      '2',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onNumberPressed('3'),
                    child: const Text(
                      '3',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 143, 171, 1)),
                    onPressed: () => _onOperatorPressed('+'),
                    child: const Text(
                      '+',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140.0, // Button width

                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                      onPressed: () => _onNumberPressed('0'),
                      child: const Text(
                        '0',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 194, 209, 1)),
                    onPressed: () => _onDecimalPressed(),
                    child: const Text(
                      '.',
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 143, 171, 1)),
                    onPressed: _onEqualPressed,
                    child: const Text(
                      '=',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
